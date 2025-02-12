LIBRARY ieee;
use ieee.std_logic_1164.all;

entity full_adder_4bit is
port (
   BUS0_b3, BUS1_b3, BUS0_b2, BUS1_b2, BUS0_b1, BUS1_b1, BUS0_b0, BUS1_b0 : in std_logic;
	Carry_In : in std_logic;
	Carry_Out3 : out std_logic;
	SUM : out std_logic_vector(3 downto 0)
);
end full_adder_4bit;

architecture full_adder_4bit_logic of full_adder_4bit is
	
	component full_adder_1bit
	port (
		INPUT_A, INPUT_B : in std_logic;
		CARRY_IN : in std_logic;
		FULL_ADDER_CARRY_OUTPUT : out std_logic;
		FULL_ADDER_SUM_OUTPUT : out std_logic
	);
	end component;
	
	signal Carry_Out0 : std_logic;
	signal Carry_Out1 : std_logic;
	signal Carry_Out2 : std_logic;
	
begin
	
	INST1: full_adder_1bit port map(BUS1_b0, BUS0_b0, Carry_In, Carry_Out0, SUM(0));
	INST2: full_adder_1bit port map(BUS1_b1, BUS0_b1, Carry_Out0, Carry_Out1, SUM(1));
	INST3: full_adder_1bit port map(BUS1_b2, BUS0_b2, Carry_Out1, Carry_Out2, SUM(2));
	INST4: full_adder_1bit port map(BUS1_b3, BUS0_b3, Carry_Out2, Carry_Out3, SUM(3));

end full_adder_4bit_logic;