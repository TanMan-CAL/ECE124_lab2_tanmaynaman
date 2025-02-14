-- Members: Naman Biyani and Tanmay Shah
-- LS206_T20_LAB2

-- imports
library ieee;
use ieee.std_logic_1164.all;

-- declaring entity for logic_mux
entity logic_mux is
port(
		logic_in0, logic_in1 : in std_logic_vector(3 downto 0); -- 2 input 4-bit vectors
		logic_select : in std_logic_vector(1 downto 0); -- Input 2-bit selector to select operation
		logic_out : out std_logic_vector(3 downto 0) -- Output 4 bit vector after operation which is then used to control LEDs
);
end logic_mux;

-- architecture with functionality for the logic mux
architecture mux_logic of logic_mux is
begin

	-- mux logic based on the selector input, and performing a selected operation based on which inputs are given in the logic_select vector
	with logic_select(1 downto 0) select
	logic_out <= logic_in0 AND logic_in1 when "00",
					 logic_in0 OR logic_in1 when "01",
					 logic_in0 XOR logic_in1 when "10",
					 logic_in0 XNOR logic_in1 when "11";
	end mux_logic;
