library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity EDGEDTCTR2 is
 port (
    CLK : in std_logic;
    SYNC_IN2 : in std_logic;
    EDGE2 : out std_logic
 );
end EDGEDTCTR2;

architecture BEHAVIORAL of EDGEDTCTR2 is
    signal s_over_flag : std_logic_vector(2 downto 0);  --detectacion de flanco
    signal stable : std_logic := '0';
    signal counter   : integer range 0 to 100000 := 0; -- Contador para antirrebotes
    constant DEBOUNCE_TIME : integer := 100000;        -- Tiempo de espera
    
begin
    process (CLK)
    begin
        if rising_edge(CLK) then
            if SYNC_IN2 = stable then
                counter <= 0; 
            else
                counter <= counter + 1;
                if counter = DEBOUNCE_TIME then
                    stable <= SYNC_IN2; 
                    counter <= 0;
                end if;
            end if;

            s_over_flag <= s_over_flag(1 downto 0) & stable; 
        end if;
    end process;

    with s_over_flag select
        EDGE2 <= '1' when "100",
                '0' when others;
end BEHAVIORAL;