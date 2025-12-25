library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity SYNCHRNZR_level3 is
    Port ( clk : in STD_LOGIC;
           async_in_l3 : in STD_LOGIC;
           sync_out_l3 : out STD_LOGIC);
end SYNCHRNZR_level3;

architecture Behavioral of SYNCHRNZR_level3 is
signal desplz : std_logic_vector(1 downto 0);
begin

 process (CLK)
 begin
 if rising_edge(CLK) then
    sync_out_l3 <= desplz(1);
    desplz <= desplz(0) & async_in_l3;
 end if;
 end process;
end Behavioral;