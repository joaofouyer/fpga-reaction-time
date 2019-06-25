library ieee;
use ieee.std_logic_1164.all;

ENTITY hex7seg IS
	PORT (
			Q3   	   : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
			Q2   	   : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
			Q1   	   : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
			Q0   	   : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
         display3 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
         display2 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
         display1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
         display0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
	 );
END hex7seg;

architecture Behavorial of hex7seg is
BEGIN
	WITH Q3 SELECT display3 <=
		"1000000" WHEN "0000",
		"1111001" WHEN "0001",
		"0100100" WHEN "0010",
		"0110000" WHEN "0011",
		"0011001" WHEN "0100",
		"0010010" WHEN "0101",
		"0000010" WHEN "0110",
		"1111000" WHEN "0111",
		"0000000" WHEN "1000",
		"0011000" WHEN "1001",
		"0001000" WHEN "1010",
		"0000011" WHEN "1011",
		"1000110" WHEN "1100",
		"0100001" WHEN "1101",
		"0000110" WHEN "1110",
		"0001110" WHEN OTHERS;
		
	WITH Q2 SELECT display2 <=
		"1000000" WHEN "0000",
		"1111001" WHEN "0001",
		"0100100" WHEN "0010",
		"0110000" WHEN "0011",
		"0011001" WHEN "0100",
		"0010010" WHEN "0101",
		"0000010" WHEN "0110",
		"1111000" WHEN "0111",
		"0000000" WHEN "1000",
		"0011000" WHEN "1001",
		"0001000" WHEN "1010",
		"0000011" WHEN "1011",
		"1000110" WHEN "1100",
		"0100001" WHEN "1101",
		"0000110" WHEN "1110",
		"0001110" WHEN OTHERS;
		
	WITH Q1 SELECT display1 <=
		"1000000" WHEN "0000",
		"1111001" WHEN "0001",
		"0100100" WHEN "0010",
		"0110000" WHEN "0011",
		"0011001" WHEN "0100",
		"0010010" WHEN "0101",
		"0000010" WHEN "0110",
		"1111000" WHEN "0111",
		"0000000" WHEN "1000",
		"0011000" WHEN "1001",
		"0001000" WHEN "1010",
		"0000011" WHEN "1011",
		"1000110" WHEN "1100",
		"0100001" WHEN "1101",
		"0000110" WHEN "1110",
		"0001110" WHEN OTHERS;
		
	WITH Q0 SELECT display0 <=
		"1000000" WHEN "0000",
		"1111001" WHEN "0001",
		"0100100" WHEN "0010",
		"0110000" WHEN "0011",
		"0011001" WHEN "0100",
		"0010010" WHEN "0101",
		"0000010" WHEN "0110",
		"1111000" WHEN "0111",
		"0000000" WHEN "1000",
		"0011000" WHEN "1001",
		"0001000" WHEN "1010",
		"0000011" WHEN "1011",
		"1000110" WHEN "1100",
		"0100001" WHEN "1101",
		"0000110" WHEN "1110",
		"0001110" WHEN OTHERS;

END Behavorial;
