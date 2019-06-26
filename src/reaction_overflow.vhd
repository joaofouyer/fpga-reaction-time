library ieee;
use ieee.std_logic_1164.all;

ENTITY reaction_over IS
	PORT (
			rco_reaction: IN  STD_LOGIC;
			entrada3   	: IN  STD_LOGIC_VECTOR(6 DOWNTO 0);
			entrada2   	   	: IN  STD_LOGIC_VECTOR(6 DOWNTO 0);
			entrada1  	   	: IN  STD_LOGIC_VECTOR(6 DOWNTO 0);
			entrada0   	   	: IN  STD_LOGIC_VECTOR(6 DOWNTO 0);
         saida3 	: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
         saida2 	: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
         saida1 	: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
         saida0 	: OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
	 );
END reaction_over;

architecture Behavorial of reaction_over is
BEGIN
	WITH rco_reaction SELECT saida3 <=
		"0000110" WHEN '1',
		entrada3 WHEN OTHERS;
		
	WITH rco_reaction SELECT saida2 <=
		"0010010" WHEN '1',
		entrada2 WHEN OTHERS;
		
	WITH rco_reaction SELECT saida1 <=
		 "1000000" WHEN '1',
		entrada1 WHEN OTHERS;

	WITH rco_reaction SELECT saida0 <=
		 "1000111" WHEN '1',
		entrada0 WHEN OTHERS;

END Behavorial;

