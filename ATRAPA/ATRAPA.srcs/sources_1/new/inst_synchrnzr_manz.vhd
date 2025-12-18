library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SYNCHRNZR_MANZ1 is
 port (
    CLK : in std_logic;
    ASYNC1_IN : in std_logic;
    SYNC1_OUT : out std_logic
 );
end SYNCHRNZR_MANZ1;

architecture BEHAVIORAL of SYNCHRNZR_MANZ1 is
 signal desplz : std_logic_vector(1 downto 0);
begin

process (CLK)
 begin
 if rising_edge(CLK) then
    sync1_out <= desplz(1);
    desplz <= desplz(0) & async1_in;
 end if;
 end process;
end BEHAVIORAL;