library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SYNCHRNZR2 is
 port (
    CLK : in std_logic;
    ASYNC_IN2 : in std_logic;
    SYNC_OUT2 : out std_logic
 );
 
end SYNCHRNZR2;
    architecture BEHAVIORAL of SYNCHRNZR2 is
    signal s_over_flag : std_logic_vector(1 downto 0);
begin
 process (CLK)
    begin
    if rising_edge(CLK) then
        sync_out2 <= s_over_flag(1);
        s_over_flag <= s_over_flag(0) & async_in2;
    end if;
    end process;
end BEHAVIORAL;