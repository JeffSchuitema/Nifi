https://dlcdn.apache.org/nifi/2.0.0-M4/nifi-2.0.0-M4-bin.zip
sudo curl -o /opt/nifi/nifi-1.6.0-bin.tar.gz https://dlcdn.apache.org/nifi/2.0.0-M4/nifi-2.0.0-M4-bin.zip

# download the tar ball
sudo curl -o /opt/nifi/nifi-1.6.0-bin.tar.gz http://apache.melbourneitmirror.net/nifi/1.6.0/nifi-1.6.0-bin.tar.gz
sudo curl -o /opt/nifi/nifi-toolkit-1.6.0-bin.tar.gz http://mirror.ventraip.net.au/apache/nifi/1.6.0/nifi-toolkit-1.6.0-bin.tar.gz

# decompress and untar
cd /opt/nifi/
sudo tar -xzf nifi-1.6.0-bin.tar.gz 
sudo tar -xzf nifi-toolkit-1.6.0-bin.tar.gz
sudo chown -R nifi:nifi /opt/nifi/nifi-1.6.0
sudo chown -R nifi:nifi /opt/nifi/nifi-toolkit-1.6.0

# configure HTTP access on port:38080 in /opt/nifi/nifi-1.6.0/conf/nifi.properties
nifi.web.http.port=38080

# start nifi service
sudo /opt/nifi/nifi-1.6.0/bin/nifi.sh install
sudo service nifi start

# check access
curl -i http://localhost:38080/nifi

# enable HTTPS access
cd /opt/nifi/nifi-toolkit-1.6.0/bin
./tls-toolkit.sh standalone -n localhost -C 'CN=admin, OU=NIFI'
mv CN\=admin_OU\=NIFI.p* localhost/
mv nifi-* localhost/
cp localhost/* /opt/nifi/nifi-1.6.0/conf/
cd /opt/nifi/nifi-1.6.0/conf/
cat nifi.properties | grep -i nifi.security.keystorePasswd
nifi.security.keystorePasswd=FAWX9Kht/LnUg0IRUX271KaOsDyk7NElfJPm4jjRIUA
keytool -v -list -keystore keystore.jks

cat CN\=admin_OU\=NIFI.password 
jePx2N90PTfrGroP5jEJX1cNvjc72zftvCjJ7Q+2h70

install apache directory server
wget http://apache.mirror.serversaustralia.com.au//directory/apacheds/dist/2.0.0-M24/apacheds-2.0.0-M24-x86_64.rpm

sudo service apacheds-2.0.0_M24-default status
yum install -y openldap-clients

ldapsearch -D "uid=admin,ou=system" -w secret -p 10389 -h localhost -b "ou=system"

# generate another client certificate
[nifi@centos /opt/nifi/nifi-toolkit-1.6.0/bin]$ ./tls-toolkit.sh standalone -C 'CN=initial_user, OU=NIFI'
tls-toolkit.sh: JAVA_HOME not set; results may vary

cat CN\=initial_user_OU\=NIFI.password 
LR5mLUmeKf8AICQLkuJ8jhQE+R3hmJiPPL+pQslolV4
