LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY unidade_de_controle IS
  PORT (
			 clear					:		IN 	STD_LOGIC;
			 start					:		IN 	STD_LOGIC;
			 led_on					:		IN 	STD_LOGIC;
			 reaction_overflow	:		IN 	STD_LOGIC;
			 button					:		IN 	STD_LOGIC;
			 clock					:		IN 	STD_LOGIC;
			 start_cont_led		:		OUT	STD_LOGIC;
			 start_cont_reaction	:		OUT	STD_LOGIC;
			 rco_led					:		OUT	STD_LOGIC;
			 rco_reaction			:		OUT	STD_LOGIC
		 );
END unidade_de_controle;

ARCHITECTURE Behavorial OF unidade_de_controle IS
	TYPE tipo_estado IS (iniciando, contando_led, contando_reacao, carregado);
	SIGNAL estado   : tipo_estado; 
BEGIN
	PROCESS (clear, start, clock, estado)
	BEGIN
	IF clear = '1' THEN
		estado <= iniciando;
	ELSIF (clock'event AND clock = '1') THEN
		CASE estado IS
			WHEN iniciando =>
				IF start = '1' THEN
					estado <= contando_led;
				ELSE
					estado <= iniciando;
				END IF;
			
			WHEN contando_led =>
				IF led_on = '1' THEN
					estado <= contando_reacao;
				ELSIF button = '1' THEN
					estado <= iniciando;
				ELSE
					estado <= contando_led;
				END IF;
				
			WHEN contando_reacao =>
				IF button = '1' OR reaction_overflow = '1' THEN
					estado <= carregado;
				END IF;
			WHEN carregado =>
				estado <= carregado;
		END CASE;
	END IF;
	END PROCESS;
	
	start_cont_led 		<= '1' WHEN estado = contando_led 		ELSE '0';
	start_cont_reaction 	<= '1' WHEN estado = contando_reacao 	ELSE '0';
	rco_led 					<= '1' WHEN estado = contando_reacao 	ELSE '0';
	rco_reaction 			<= '1' WHEN estado = carregado AND reaction_overflow = '1' ELSE '0';
	
	
END Behavorial;