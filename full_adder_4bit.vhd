-- Members: Naman Biyani and Tanmay Shah
-- LS206_T20_LAB2

-- imports
LIBRARY ieee;
use ieee.std_logic_1164.all;

-- Declaring entity for Full Adder 4-bit
entity full_adder_4bit is
port (
   BUS0_b3, BUS1_b3, BUS0_b2, BUS1_b2, BUS0_b1, BUS1_b1, BUS0_b0, BUS1_b0 : in std_logic; -- inputs for 2-to-1 muxes
	Carry_In : in std_logic; -- Carry input from the previous stage
	Carry_Out3 : out std_logic; -- Final carryout for the most significant bit
	SUM : out std_logic_vector(3 downto 0) -- 4-bit sum output
);
end full_adder_4bit;

-- architecture for full adder 4-bit containing logic and functionality
architecture full_adder_4bit_logic of full_adder_4bit is

	-- Component declaration for 1-bit adder created in full_adder_1bit.vhd
	component full_adder_1bit
	port (
		INPUT_A, INPUT_B : in std_logic; -- 2 1-bit inputs for 1-bit adder
		CARRY_IN : in std_logic; -- Carry input for 1-bit adder
		FULL_ADDER_CARRY_OUTPUT : out std_logic; -- Carry output from 1-bit adder
		FULL_ADDER_SUM_OUTPUT : out std_logic -- Sum output from 1-bit adder
	);
	end component;

	-- Signals to hold carry outputs while processing to pass through calls
	signal Carry_Out0 : std_logic;
	signal Carry_Out1 : std_logic;
	signal Carry_Out2 : std_logic;
	
begin
	-- Instantiating 4 1-bit adders to create a 4-bit full adder
	-- Each instance propogates to the next to with the carry
	INST1: full_adder_1bit port map(BUS1_b0, BUS0_b0, Carry_In, Carry_Out0, SUM(0)); -- LSB
	INST2: full_adder_1bit port map(BUS1_b1, BUS0_b1, Carry_Out0, Carry_Out1, SUM(1));
	INST3: full_adder_1bit port map(BUS1_b2, BUS0_b2, Carry_Out1, Carry_Out2, SUM(2));
	INST4: full_adder_1bit port map(BUS1_b3, BUS0_b3, Carry_Out2, Carry_Out3, SUM(3)); -- MSB

end full_adder_4bit_logic;
