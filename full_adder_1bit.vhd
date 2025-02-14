-- Members: Naman Biyani and Tanmay Shah
-- LS206_T20_LAB2

library ieee;
use ieee.std_logic_1164.all;

-- entity declaration for a 1-bit full adder
entity full_adder_1bit is
    port (
        INPUT_A, INPUT_B : in std_logic;                        -- 1-bit inputs for addition
        CARRY_IN : in std_logic;                                -- carry input
        FULL_ADDER_CARRY_OUTPUT : out std_logic;                -- carry output to the next bit
        FULL_ADDER_SUM_OUTPUT : out std_logic                   -- sum output
    );
end full_adder_1bit;

-- definition for implementing the full adder logic
architecture mux_logic of full_adder_1bit is
begin 
    -- carry logic:
    -- if both INPUT_A and INPUT_B are 1 (AND) or if one of them is 1 and the carry-in is also 1
    FULL_ADDER_CARRY_OUTPUT <= (INPUT_A AND INPUT_B) OR (CARRY_IN AND (INPUT_A XOR INPUT_B));
    
    -- sum logic:
    -- is calculated as an XOR of INPUT_A, INPUT_B, and CARRY_IN, hence produces the sum output for the current bit
    FULL_ADDER_SUM_OUTPUT <= (INPUT_A XOR INPUT_B) XOR CARRY_IN;
    
end mux_logic;
