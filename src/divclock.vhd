LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY divclock IS
    PORT (
		  clock     : IN  STD_LOGIC;
		  clear		: IN  STD_LOGIC;
        clock_div : OUT STD_LOGIC
    );
END divclock;

ARCHITECTURE Behavioral OF divclock IS
	SIGNAL IQ	: UNSIGNED(24 DOWNTO 0);
	SIGNAL pivo	: STD_LOGIC;
BEGIN
	
	PROCESS (clock, clear, IQ, pivo)
	BEGIN
	
	IF clear = '1' THEN
		IQ   <= (OTHERS => '0');
		pivo <= '0';

	ELSIF clock'event AND clock = '1' THEN
		IQ <= IQ + 1;
		
			IF IQ = 25000 THEN 
				pivo <= NOT(pivo);
				IQ   <= (OTHERS => '0');
		END IF;
	END IF;
	 
	clock_div <= pivo;
	END PROCESS;
	
END Behavioral;