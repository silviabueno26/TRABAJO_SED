library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SYNCHRNZR_level2 is
    Port ( clk : in STD_LOGIC;
           async_in_l2 : in STD_LOGIC;
           sync_out_l2 : out STD_LOGIC);
end SYNCHRNZR_level2;

architecture Behavioral of SYNCHRNZR_level2 is

signal desplz : std_logic_vector(1 downto 0);
begin

 process (CLK)
 begin
 if rising_edge(CLK) then
    sync_out_l2 <= desplz(1);
    desplz <= desplz(0) & async_in_l2;
 end if;
 end process;
 
end Behavioral;
