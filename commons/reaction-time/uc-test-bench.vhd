--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:49:53 06/25/2019
-- Design Name:   
-- Module Name:   C:/Users/fouyer/Documents/DSD/fpga-reaction-time/commons/reaction-time/uc-test-bench.vhd
-- Project Name:  reaction-time
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: unidade_de_controle
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY uc-test-bench IS
END uc-test-bench;
 
ARCHITECTURE behavior OF uc-test-bench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT unidade_de_controle
    PORT(
         clear : IN  std_logic;
         start : IN  std_logic;
         led_on : IN  std_logic;
         reaction_overflow : IN  std_logic;
         button : IN  std_logic;
         clock : IN  std_logic;
         start_cont_led : OUT  std_logic_vector(2 downto 0);
         start_cont_reaction : OUT  std_logic;
         rco_led : OUT  std_logic;
         rco_reaction : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clear : std_logic := '0';
   signal start : std_logic := '0';
   signal led_on : std_logic := '0';
   signal reaction_overflow : std_logic := '0';
   signal button : std_logic := '0';
   signal clock : std_logic := '0';

 	--Outputs
   signal start_cont_led : std_logic_vector(2 downto 0);
   signal start_cont_reaction : std_logic;
   signal rco_led : std_logic;
   signal rco_reaction : std_logic;

   -- Clock period definitions
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: unidade_de_controle PORT MAP (
          clear => clear,
          start => start,
          led_on => led_on,
          reaction_overflow => reaction_overflow,
          button => button,
          clock => clock,
          start_cont_led => start_cont_led,
          start_cont_reaction => start_cont_reaction,
          rco_led => rco_led,
          rco_reaction => rco_reaction
        );

   -- Clock process definitions
   clock_process :process
   begin
		clock <= '0';
		wait for clock_period/2;
		clock <= '1';
		wait for clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clock_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
