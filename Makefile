SOURCE="https://releases.mattermost.com/desktop/4.3.1/mattermost-desktop-4.3.1-linux-x64.tar.gz"
DESTINATION="build.tar.gz"
OUTPUT="Mattermost.AppImage"


all:
	echo "Building: $(OUTPUT)"
	wget -O $(DESTINATION) -c $(SOURCE)
	
	tar -zxvf $(DESTINATION)
	rm -rf AppDir/opt
	
	mkdir --parents AppDir/opt/application
	mv mattermost-desktop-4.3.1-linux-x64/* AppDir/opt/application

	chmod +x AppDir/AppRun

	appimagetool AppDir $(OUTPUT)

	rm -f $(DESTINATION)
	rm -rf mattermost-desktop-4.3.1-linux-x64
	rm -rf AppDir/opt
