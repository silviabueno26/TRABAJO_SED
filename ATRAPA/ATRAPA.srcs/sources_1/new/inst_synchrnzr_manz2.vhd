library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SYNCHRNZR_MANZ2 is
 port (
    CLK : in std_logic;
    ASYNC2_IN : in std_logic;
    SYNC2_OUT : out std_logic
 );
end SYNCHRNZR_MANZ2;


architecture BEHAVIORAL of SYNCHRNZR_MANZ2 is
 signal desplz : std_logic_vector(1 downto 0);
begin
 process (CLK)
 
 begin
 if rising_edge(CLK) then
    sync2_out <= desplz(1);
    desplz<= desplz(0) & async2_in;
 end if;
 end process;
end BEHAVIORAL;