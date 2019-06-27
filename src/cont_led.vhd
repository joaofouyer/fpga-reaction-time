LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;

ENTITY cont_led IS
    PORT (
			enable			:		IN		STD_LOGIC;
			random_time		:		IN		STD_LOGIC_VECTOR(13 DOWNTO 0);
			clear				:		IN		STD_LOGIC;
			clock				:		IN		STD_LOGIC;
			rco_led			:		OUT	STD_LOGIC
		 );
END cont_led;

ARCHITECTURE Behavorial OF cont_led IS
	SIGNAL IQ	: 	UNSIGNED (20 DOWNTO 0);
BEGIN
	PROCESS (enable, clear, clock, IQ)
	BEGIN
		IF clear = '1' THEN
			IQ <= (OTHERS => '0');
		ELSIF clock'event AND enable = '1' AND IQ < unsigned(random_time) AND clock = '1' THEN
			IQ <= IQ + 1;
		END IF;
	END PROCESS;
	rco_led <= '1' WHEN (IQ = unsigned(random_time)) ELSE '0';
END Behavorial;