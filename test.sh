echo "********************Make clean*******************"
echo ""
make clean

echo "********************Make*************************"
echo ""
make

echo "********************Run cRemover*****************"
echo ""
./cRemover.exe

echo "********************Run Language*****************"
echo ""
./lang < part2.txt

