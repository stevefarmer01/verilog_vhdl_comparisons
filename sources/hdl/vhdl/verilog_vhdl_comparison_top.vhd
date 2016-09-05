----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.03.2016 13:25:16
-- Design Name: 
-- Module Name: level_change_domain_top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity verilog_vhdl_comparison_top is
    generic(number_of_domain_cross_regs : natural := 3);
    Port ( 
           --signal_in : in  std_logic_vector(3 downto 0);
           signal_in_bit : in  std_logic;
           SystemClk : in  std_logic;
           --signal_out : out  std_logic_vector(3 downto 0);
           signal_out_bit : out  std_logic := '0'
           );
end verilog_vhdl_comparison_top;

architecture Behavioral of verilog_vhdl_comparison_top is

--component level_change_domain
--    generic(number_of_domain_cross_regs : natural := 2);
--    Port ( signal_in : in  std_logic_vector;
--           SystemClk : in  std_logic;
--           signal_out : out  std_logic_vector
--           );
--end component;

signal signal_in_bit_r, signal_out_bit_s : std_logic := '0';

begin

in_reg_proc : process
begin 
  wait until rising_edge(SystemClk);
  signal_in_bit_r <= signal_in_bit;
end process;


--inst_level_change_domain_bit : level_change_domain
--    generic map(
--            number_of_domain_cross_regs => number_of_domain_cross_regs -- : natural := 2
--            )
--    Port map( 
--            signal_in(0) => signal_in_bit_r,  -- : in  std_logic_vector;
--            SystemClk => SystemClk,         -- : in  std_logic;
--            signal_out(0) => signal_out_bit_s -- : out  std_logic_vector
--           );

signal_out_bit_s <= signal_in_bit_r;

out_reg_proc : process
begin 
  wait until rising_edge(SystemClk);
  signal_out_bit <= signal_out_bit_s;
end process;

--signal_out_bit <= signal_out_bit_r;

--mult_output <= unsigned(input_a) * unsigned(input_b);

end Behavioral;
