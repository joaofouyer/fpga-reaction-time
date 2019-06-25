LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;

ENTITY cont_led IS
    PORT (
			start_cont_led	:		IN		STD_LOGIC;
			clear				:		IN		STD_LOGIC;
			clock				:		IN		STD_LOGIC;
			rco_led			:		OUT	STD_LOGIC
		 );
END cont_led;

ARCHITECTURE Behavorial OF cont_led IS
	SIGNAL IQ	: 	UNSIGNED (20 DOWNTO 0);
BEGIN
	PROCESS (start_cont_led, clear, clock, IQ)
	BEGIN
		IF clear = '1' THEN
			IQ <= (OTHERS => '0');
		ELSIF clock'event AND start_cont_led = '1' AND IQ < 4200 AND clock = '1' THEN
			IQ <= IQ + 1;
		END IF;
	END PROCESS;
	rco_led <= '1' WHEN (IQ = 4200) ELSE '0';
END Behavorial;