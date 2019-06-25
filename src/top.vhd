LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY top IS
    PORT (
		clear			: 	IN 	STD_LOGIC;									
      start			: 	IN 	STD_LOGIC;									
      button		: 	IN 	STD_LOGIC;									
      clock			: 	IN 	STD_LOGIC;
		display		: 	OUT	STD_LOGIC_VECTOR(6 DOWNTO 0);
		anodes		:	OUT	STD_LOGIC_VECTOR(3 DOWNTO 0);
      rco_led		: 	OUT	STD_LOGIC;
		rco_reaction:	OUT	STD_LOGIC;
		overflow_rco: 	OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END top;

ARCHITECTURE medidor OF top IS
	SIGNAL	start_cont_led			: STD_LOGIC;
	SIGNAL	start_cont_reaction	: STD_LOGIC;
	SIGNAL	led_on					: STD_LOGIC;
	SIGNAL	reaction_overflow		: STD_LOGIC;
	
	COMPONENT unidade_de_controle IS
		 PORT (
			clear						:		IN 	STD_LOGIC;
			start						:		IN		STD_LOGIC;
			led_on					:		IN 	STD_LOGIC;
			reaction_overflow		:		IN 	STD_LOGIC;
			button					:		IN 	STD_LOGIC;
			clock						:		IN 	STD_LOGIC;
			start_cont_led			:		OUT	STD_LOGIC; 	--	ESTADO CONTANDO PRA ACENDER O LED
			start_cont_reaction	:		OUT	STD_LOGIC;	--	ESTADO CONTANDO DEPOIS QUE O LED ACENDEU
			rco_led					:		OUT	STD_LOGIC;
			rco_reaction			:		OUT	STD_LOGIC
		 );
	END COMPONENT;
	
	COMPONENT fluxo_de_dados IS
		 PORT (
			 clock					:	IN 	STD_LOGIC;
			 clear					:	IN		STD_LOGIC;
			 start_cont_led		:	IN		STD_LOGIC;
			 start_cont_reaction	:	IN		STD_LOGIC;
			 rco_led					:	OUT	STD_LOGIC;
			 rco_reaction			:	OUT	STD_LOGIC;
			 display					:	OUT	STD_LOGIC_VECTOR(6 DOWNTO 0);
			 anodes					:	OUT	STD_LOGIC_VECTOR(3 DOWNTO 0)
		 );
	END COMPONENT;
	
BEGIN
	uc		: unidade_de_controle 	PORT MAP(clear, start, led_on, reaction_overflow, button, clock, start_cont_led, start_cont_reaction, rco_led, rco_reaction);
	fluxo	: fluxo_de_dados 			PORT MAP(clock, clear, start_cont_led, start_cont_reaction, led_on, reaction_overflow, display, anodes);
	overflow_rco <= (OTHERS => reaction_overflow);
END medidor;