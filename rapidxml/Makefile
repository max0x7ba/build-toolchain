include ../versions.mk

PREFIX := ${prefix}/rapidxml-${rapidxml_version}

all : install.rapidxml.${rapidxml_version}

${PREFIX} : ${DOWNLOAD_DIR}/rapidxml-${rapidxml_version}.zip
	unzip -d ${@D} $<
	stat $@ > /dev/null
	touch $@

install.rapidxml.${rapidxml_version} : ${PREFIX}

${DOWNLOAD_DIR}/rapidxml-${rapidxml_version}.zip : | ${DOWNLOAD_DIR}
	wget -O $@~ http://netcologne.dl.sourceforge.net/project/rapidxml/rapidxml/rapidxml%20${rapidxml_version}/rapidxml-${rapidxml_version}.zip
	mv $@{~,}

download : ${DOWNLOAD_DIR}/rapidxml-${rapidxml_version}.zip

clean :
	rm -rf *.rapidxml.${rapidxml_version} ${PREFIX}

.PHONY: all clean download
