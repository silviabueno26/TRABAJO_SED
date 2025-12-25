library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity EDGEDTCTR_level1 is
    Port ( clk : in STD_LOGIC;
           sync_in_l1 : in STD_LOGIC;
           edgel1 : out STD_LOGIC);
end EDGEDTCTR_level1;

architecture Behavioral of EDGEDTCTR_level1 is
signal desplz : std_logic_vector(2 downto 0);
begin


 process (CLK)
 begin
 if rising_edge(CLK) then
    desplz <= desplz(1 downto 0) & SYNC_IN_L1;
 end if;
 end process;
 
 with desplz select
    EDGEL1 <= '1' when "100",
    '0' when others;
end Behavioral;
