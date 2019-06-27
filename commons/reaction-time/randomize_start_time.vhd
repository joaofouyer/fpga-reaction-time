LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;

ENTITY randomize_time IS
	PORT (
			clock     	: IN  STD_LOGIC;
			enable		: IN	STD_LOGIC; 
			random_time	: OUT STD_LOGIC_VECTOR(13 DOWNTO 0)
	);
END randomize_time;

ARCHITECTURE Behavorial OF randomize_time IS
	SIGNAL random_read : UNSIGNED(1 DOWNTO 0) := (OTHERS => '0'); 
BEGIN
	PROCESS (clock, enable)
	BEGIN
		IF enable = '1' THEN
			IF random_read = 0 THEN
				random_time <= "00000110100100";
			ELSIF random_read = 1 THEN
				random_time <= "00100010101110";
			ELSIF random_read = 2 THEN
				random_time <= "01000001101000";
			ELSE
				random_time <= "01101000001010";
			END IF;
		ELSE
			random_read <= random_read + 1;
		END IF;
	END PROCESS;
END Behavorial;