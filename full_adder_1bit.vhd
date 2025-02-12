library ieee;
use ieee.std_logic_1164.all;

entity full_adder_1bit is
port (
	INPUT_A, INPUT_B : in std_logic;
	CARRY_IN : in std_logic;
	FULL_ADDER_CARRY_OUTPUT : out std_logic;
	FULL_ADDER_SUM_OUTPUT : out std_logic
);
end full_adder_1bit;

architecture mux_logic of full_adder_1bit is

begin 

		FULL_ADDER_CARRY_OUTPUT <= (INPUT_A AND INPUT_B) OR (CARRY_IN AND (INPUT_A XOR INPUT_B));
		
		FULL_ADDER_SUM_OUTPUT <= (INPUT_A XOR INPUT_B) XOR CARRY_IN;
		
end mux_logic;