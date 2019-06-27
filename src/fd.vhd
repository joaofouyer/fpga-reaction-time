LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY fluxo_de_dados IS
	PORT (
			 clock					:	IN 	STD_LOGIC; 							-- Clock da placa.
			 clear					:	IN		STD_LOGIC; 							-- Limpar tudo!
			 start_game				:	IN		STD_LOGIC; 							-- Botão pressionado para começar o jogo. Acende o LED após Xms
			 start_cont_reaction	:	IN		STD_LOGIC;							-- Começar a contar o tempo de reação!
			 button					:	IN		STD_LOGIC;	
			 rco_led					:	OUT 	STD_LOGIC;							-- RCO do contador do LED, que... acende o LED!
			 rco_reaction			:	OUT 	STD_LOGIC;							-- RCO do contador de reação que indica que o tempo máximo foi atingido!
			 display					:	OUT	STD_LOGIC_VECTOR(6 DOWNTO 0);	--	O display de 7 segmentos
			 anodes					:	OUT	STD_LOGIC_VECTOR(3 DOWNTO 0)	--	Anodes?
			 
		 );
END fluxo_de_dados;


ARCHITECTURE Behavioral OF fluxo_de_dados IS
	SIGNAL	clock1Mhz 				: STD_LOGIC;
	SIGNAL	led_on	 				: STD_LOGIC;
	SIGNAL	RCO_REACTION_READ	 	: STD_LOGIC;
	SIGNAL	random_start_time 	: STD_LOGIC_VECTOR(13 DOWNTO 0);
	SIGNAL	violated_reaction	 	: STD_LOGIC;
	
	SIGNAL	cont_uni 				: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL	cont_dez					: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL	cont_cen					: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL	cont_mil 				: STD_LOGIC_VECTOR(3 DOWNTO 0);
	
	SIGNAL	saida3	   			: STD_LOGIC_VECTOR(6 DOWNTO 0);
	SIGNAL	saida2	   			: STD_LOGIC_VECTOR(6 DOWNTO 0);
	SIGNAL	saida1	   			: STD_LOGIC_VECTOR(6 DOWNTO 0);
	SIGNAL	saida0	   			: STD_LOGIC_VECTOR(6 DOWNTO 0);
	
	SIGNAL	display3	   			: STD_LOGIC_VECTOR(6 DOWNTO 0);
	SIGNAL	display2	   			: STD_LOGIC_VECTOR(6 DOWNTO 0);
	SIGNAL	display1	   			: STD_LOGIC_VECTOR(6 DOWNTO 0);
	SIGNAL	display0	   			: STD_LOGIC_VECTOR(6 DOWNTO 0);
	
	COMPONENT divclock IS
		PORT (
		  clock     : IN  STD_LOGIC;
		  clear		: IN  STD_LOGIC;
        clock_div : OUT STD_LOGIC
    );
	END COMPONENT;
	
	COMPONENT randomize_time IS
		PORT (
			clock     			: IN  STD_LOGIC;
			enable     			: IN  STD_LOGIC;
			random_time			: OUT STD_LOGIC_VECTOR(13 DOWNTO 0)	
    );
	END COMPONENT;
	
	COMPONENT cont_led IS
		PORT (
			clock						:		IN		STD_LOGIC;
			enable					:		IN		STD_LOGIC;
			random_time				:		IN		STD_LOGIC_VECTOR(13 DOWNTO 0);
			clear						:		IN		STD_LOGIC;
			reaction_btn			:		IN		STD_LOGIC;
			rco_led					:		OUT	STD_LOGIC;
			violated_react			:		OUT	STD_LOGIC
		 );
	END COMPONENT;
	
	COMPONENT cont_reacao IS
		PORT (
			clock						:	IN		STD_LOGIC;
			start_cont_reaction	:	IN		STD_LOGIC;
			clear						:	IN		STD_LOGIC;
			violated					:	IN		STD_LOGIC;
			cont_uni					:	OUT	STD_LOGIC_VECTOR(3 DOWNTO 0);
			cont_dez					:	OUT	STD_LOGIC_VECTOR(3 DOWNTO 0);
			cont_cen					:	OUT	STD_LOGIC_VECTOR(3 DOWNTO 0);
			cont_mil					:	OUT	STD_LOGIC_VECTOR(3 DOWNTO 0);
			rco						:	OUT	STD_LOGIC
		 );
	END COMPONENT;
	
	COMPONENT hex7seg IS
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
	END COMPONENT;
	
	COMPONENT reaction_over IS
		PORT(
			rco_reaction   : IN  std_logic;
			entrada3			: IN  std_logic_vector(6 DOWNTO 0);
			entrada2 		: IN  std_logic_vector(6 DOWNTO 0);
			entrada1 		: IN  std_logic_vector(6 DOWNTO 0);
			entrada0 		: IN  std_logic_vector(6 DOWNTO 0);
			saida3			: OUT std_logic_vector(6 DOWNTO 0);
			saida2	 		: OUT std_logic_vector(6 DOWNTO 0);
			saida1	 		: OUT std_logic_vector(6 DOWNTO 0);
			saida0	 		: OUT std_logic_vector(6 DOWNTO 0)
		);
	END COMPONENT;
	
	COMPONENT multi_display IS
		PORT(
			clock    : IN  std_logic;
			entrada3 : IN  std_logic_vector(6 DOWNTO 0);
			entrada2 : IN  std_logic_vector(6 DOWNTO 0);
			entrada1 : IN  std_logic_vector(6 DOWNTO 0);
			entrada0 : IN  std_logic_vector(6 DOWNTO 0);
			sevenseg : OUT std_logic_vector(6 DOWNTO 0);
			anodes  	: OUT std_logic_vector(3 DOWNTO 0)
		);
	END COMPONENT;
	
	
BEGIN
	div_clock				:	divclock 			PORT MAP(clock, clear, clock1Mhz);
	randomize_start_time	:	randomize_time		PORT MAP(clock1Mhz, start_game, random_start_time);
	contador_led			:	cont_led 			PORT MAP(
																clock1Mhz, 
																start_game, 
																random_start_time, 
																clear, 
																button, 
																led_on,
																violated_reaction
															);
	rco_led <= led_on;
	contador_reacao		:	cont_reacao 		PORT MAP(
																clock1Mhz, 
																start_cont_reaction, 
																clear,
																violated_reaction,
																cont_uni, 
																cont_dez, 
																cont_cen, 
																cont_mil, 
																RCO_REACTION_READ
															);	
	
	rco_reaction <= RCO_REACTION_READ;
	
	display7seg				:	hex7seg				PORT MAP(cont_uni, cont_dez, cont_cen, cont_mil, saida3, saida2, saida1, saida0);
	reactionover			:	reaction_over		PORT MAP(RCO_REACTION_READ, saida3, saida2, saida1, saida0, display3, display2, display1, display0);
	mdisplay					:	multi_display		PORT MAP(clock, display3, display2, display1, display0, display, anodes);
	
END Behavioral;