FROM debian:wheezy
MAINTAINER Michael Bortlik <Michael.Bortlik@gmail.com>

# Set environment variables for build and entrypoint
ENV DATA_FOLDER="/bloqster" \
	ECO_VERSION="0.7.2.5-beta" \
	ECO_SERVER_FILES="/opt/eco" \
	ECO_STORAGE_FOLDER="/bloqster/storage" \
	ECO_CONFIG_FOLDER="/bloqster/config" \
	ECO_SERVER_USER="eco_server" \
	ECO_SERVER_GROUP=eco_server

# add user and group for the service to run under
RUN groupadd -r ${ECO_SERVER_GROUP} \
	&& useradd -r -g ${ECO_SERVER_GROUP} ${ECO_SERVER_USER} 

# add mono repo
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
RUN echo "deb http://download.mono-project.com/repo/debian wheezy main" | tee /etc/apt/sources.list.d/mono-xamarin.list

# install all needed packages
RUN apt-get update \
	&& apt-get upgrade -y \
	&& apt-get dist-upgrade -y \
	&& apt-get install -y mono-complete wget unzip \
	&& rm -r /var/lib/apt/lists/*


#download eco server
RUN mkdir -p ${ECO_SERVER_FILES} \
	&& cd ${ECO_SERVER_FILES} \
	&& wget https://s3-us-west-2.amazonaws.com/eco-releases/EcoServer_v${ECO_VERSION}.zip \
	&& unzip EcoServer_v${ECO_VERSION}.zip \
	&& rm EcoServer_v${ECO_VERSION}.zip

#create folders and move files
RUN chown -R ${ECO_SERVER_USER}:${ECO_SERVER_USER} ${ECO_SERVER_FILES} \
	&& mkdir -p ${ECO_STORAGE_FOLDER} \
	&& mkdir -p ${ECO_CONFIG_FOLDER} \
	&& mv ${ECO_SERVER_FILES}/Storage/* ${ECO_STORAGE_FOLDER} \
	&& mv ${ECO_SERVER_FILES}/Configs/* ${ECO_CONFIG_FOLDER} \
	&& rm -R ${ECO_SERVER_FILES}/Storage \
	&& rm -R ${ECO_SERVER_FILES}/Configs

#expose ports
#GameServerPort
EXPOSE 3000 
#WebServerPort
EXPOSE 3001 

#create volumes 
VOLUME ${DATA_FOLDER}

#entryscript
ADD ./scripts/start.sh /
RUN chmod 755 /start.sh \
	&& chown ${ECO_SERVER_USER}:${ECO_SERVER_USER} /start.sh
ENTRYPOINT ["/start.sh"]

#have fun!
