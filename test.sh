echo "***Clean****"
rm *.exe #part1.txt part2.txt
echo "***Run make.***"
make

echo "***Run main.exe.***"
./main.exe
echo "***Cat part1.exe***"
cat part1.txt
echo "***Cat Part2.exe***"
cat part2.txt
echo "***Build script has terminated.***"
