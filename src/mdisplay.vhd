LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY multi_display IS
    PORT(
        clock     : IN  STD_LOGIC;
		  entrada3  : IN  STD_LOGIC_VECTOR(6 DOWNTO 0);
		  entrada2  : IN  STD_LOGIC_VECTOR(6 DOWNTO 0);
		  entrada1  : IN  STD_LOGIC_VECTOR(6 DOWNTO 0);
		  entrada0  : IN  STD_LOGIC_VECTOR(6 DOWNTO 0);
        sevenseg  : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        anodes  	: OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END multi_display;

ARCHITECTURE Behavioral OF multi_display IS
    SIGNAL prescaler: 			STD_LOGIC_VECTOR(16 DOWNTO 0) := "11000011010100000";
    SIGNAL prescaler_counter: STD_LOGIC_VECTOR(16 DOWNTO 0);
    SIGNAL counter: 				STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL r_anodes: 			STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN

	-- Redutor de Clock
	countClock: PROCESS(clock, counter)
   BEGIN
		IF clock'event AND clock = '1' THEN
			prescaler_counter <= prescaler_counter + 1;
				
			IF(prescaler_counter = prescaler) THEN
				counter <= counter + 1;
				prescaler_counter <= (OTHERS => '0');
			END IF;
		END IF;
	END PROCESS;

    -- Multiplexacao dos Displays
	multiplex: PROCESS(counter)
   BEGIN
		-- Selecao dos anodos
			CASE counter(1 DOWNTO 0) IS
				WHEN "00" => r_anodes <= "1110"; -- AN 0
				WHEN "01" => r_anodes <= "1101"; -- AN 1
				WHEN "10" => r_anodes <= "1011"; -- AN 2
            WHEN "11" => r_anodes <= "0111"; -- AN 3

            WHEN OTHERS => r_anodes <= "1111"; -- nothing
			END CASE;

		-- Atribui as entradas aos displays
			CASE r_anodes IS
			WHEN "1110" => 
					sevenseg <= entrada0;

				WHEN "1101" => 
					sevenseg <= entrada1;

				WHEN "1011" => 
					sevenseg <= entrada2;

            WHEN "0111" => 
					sevenseg <= entrada3;

            WHEN OTHERS => 
					sevenseg <= "1000000"; -- 0
        END CASE;

	END PROCESS;

	anodes <= r_anodes;
END Behavioral;