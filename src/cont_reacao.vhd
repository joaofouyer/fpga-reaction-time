LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;

ENTITY cont_reacao IS
    PORT (
			clock						:	IN		STD_LOGIC;
			start_cont_reaction	:	IN		STD_LOGIC;
			clear						:	IN		STD_LOGIC;
			violated					:	IN		STD_LOGIC;
			cont_uni					:	OUT	STD_LOGIC_VECTOR(3 downto 0);
			cont_dez					:	OUT	STD_LOGIC_VECTOR(3 downto 0);
			cont_cen					:	OUT	STD_LOGIC_VECTOR(3 downto 0);
			cont_mil					:	OUT	STD_LOGIC_VECTOR(3 downto 0);
			rco						:	OUT	STD_LOGIC
		 );
END cont_reacao;

ARCHITECTURE Behavorial OF cont_reacao IS
	SIGNAL IQ_UNI		: 	unsigned (3 DOWNTO 0);
	SIGNAL IQ_DEZ		: 	unsigned (3 DOWNTO 0);
	SIGNAL IQ_CEN		: 	unsigned (3 DOWNTO 0);
	SIGNAL IQ_MIL		: 	unsigned (3 DOWNTO 0);
	SIGNAL RCO_READ	: 	STD_LOGIC;
BEGIN

	PROCESS (start_cont_reaction, clear, clock, IQ_UNI, IQ_DEZ, IQ_CEN, IQ_MIL, RCO_READ)
	BEGIN
		IF clear = '1' THEN
			IQ_UNI 	<= (OTHERS => '0');
			IQ_DEZ 	<= (OTHERS => '0');
			IQ_CEN 	<= (OTHERS => '0');
			IQ_MIL 	<= (OTHERS => '0');
			RCO_READ	<= '0';
		ELSIF violated = '1' THEN
			RCO_READ	<= '1';
		ELSIF clock'event AND clock = '1' THEN
			-- Contagem da unidade começa quando encount (sinal enviado pelo acendimento do display) é igual a 1.
			IF start_cont_reaction = '1' AND RCO_READ = '0' THEN -- Quando ele atinge o valor máximo que consegue contar (9999), ele para.
				IQ_UNI <= IQ_UNI + 1;
				IF IQ_UNI = 9 THEN
					IQ_UNI <= (OTHERS => '0'); -- Zera a unidade
					-- Contagem da dezena
					IQ_DEZ <= IQ_DEZ + 1;
					IF IQ_DEZ = 9 THEN
						IQ_DEZ <= (OTHERS => '0'); -- Zera a dezena
						-- Contagem da centena
						IQ_CEN <= IQ_CEN + 1;
						IF IQ_CEN = 9 THEN
							IQ_CEN <= (OTHERS => '0'); -- Zera a centena
							-- Contagem da milhar
							IQ_MIL <= IQ_MIL + 1;
							IF IQ_MIL = 9 THEN
								RCO_READ <= '1';
							END IF;
						END IF;
					END IF;
				END IF;
			END IF;
		END IF;
		cont_uni <= STD_LOGIC_VECTOR(IQ_UNI);
		cont_dez <= STD_LOGIC_VECTOR(IQ_DEZ);
		cont_cen <= STD_LOGIC_VECTOR(IQ_CEN);
		cont_mil <= STD_LOGIC_VECTOR(IQ_MIL);
		rco 		<= RCO_READ;
	END PROCESS;
END Behavorial;