if [ "$0" == "./compose.sh" ]
then
	basepath=`pwd`
else
	basepath='/asdf/asdf'
fi
echo $basepath
cd `pwd`