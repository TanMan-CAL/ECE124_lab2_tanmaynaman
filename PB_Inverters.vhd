-- Members: Naman Biyani and Tanmay Shah
-- LS206_T20_LAB2

-- imports
LIBRARY ieee;
USE ieee.std_logic_1164.all;

-- Define Entity for PB_Inverters
ENTITY PB_Inverters IS
	PORT
	(
		pb_n : IN std_logic_vector(3 downto 0); -- Input from all 4 push buttons in active low as a 4 bit vector
		pb : OUT std_logic_vector(3 downto 0) -- Output in same format but active high through negation
	);
END PB_Inverters;


-- Defining logic for PB_Inverter in architecture
ARCHITECTURE gates of PB_Inverters IS

BEGIN
	-- The input pb_n vector is operated on with a bitwise NOT, placing the result in the output pb
	-- Functionality to change from active low to active high
	pb <= not(pb_n);

END gates;
