library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity EDGEDTCTR_MANZ1 is
 port (
    CLK : in std_logic;
    SYNC1_IN : in std_logic;
    EDGE1 : out std_logic
 );
end EDGEDTCTR_MANZ1;

architecture BEHAVIORAL of EDGEDTCTR_MANZ1 is
 signal desplz : std_logic_vector(2 downto 0);
begin

 process (CLK)
 begin
    if rising_edge(CLK) then
        desplz <= desplz(1 downto 0) & SYNC1_IN;
 end if;
 end process;
 with desplz select
    EDGE1 <= '1' when "100",
    '0' when others;
end BEHAVIORAL;