-- Members: Naman Biyani and Tanmay Shah
-- LS206_T20_ LAB2_REPORT

library ieee;
use ieee.std_logic_1164.all;

-- entity declaration for the 4-to-1 hex multiplexer
entity hex_mux is
    port (
        hex_num3, hex_num2, hex_num1, hex_num0 : in std_logic_vector(3 downto 0); -- multiplexer inputs
        mux_select                             : in std_logic_vector(1 downto 0); --  2-bit input to select one of the four inputs
        hex_out                                : out std_logic_vector(3 downto 0) -- 4-bit output corresponding to the selected input
    );
end hex_mux;

-- architecture definition for the multiplexer logic
architecture mux_logic of hex_mux is
begin
    -- depending on the value of mux_select, hex_out is assigned differently;
    with mux_select(1 downto 0) select
        hex_out <= hex_num0 when "00", 
                  hex_num1 when "01", 
                  hex_num2 when "10", 
                  hex_num3 when "11";
end mux_logic;
