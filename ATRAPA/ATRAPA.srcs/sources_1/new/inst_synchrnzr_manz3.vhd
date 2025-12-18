library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SYNCHRNZR_MANZ3 is
 port (
    CLK : in std_logic;
    ASYNC3_IN : in std_logic;
    SYNC3_OUT : out std_logic
 );
end SYNCHRNZR_MANZ3;


architecture BEHAVIORAL of SYNCHRNZR_MANZ3 is
 signal desplz : std_logic_vector(1 downto 0);
begin
 process (CLK)
 begin
    if rising_edge(CLK) then
        sync3_out <= desplz(1);
        desplz <= desplz(0) & async3_in;
 end if;
 end process;
end BEHAVIORAL;