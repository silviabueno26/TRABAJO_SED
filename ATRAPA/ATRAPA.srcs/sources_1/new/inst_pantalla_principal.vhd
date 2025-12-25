library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pantalla_principal is
    Port (
        clk: in  std_logic;
        reset: in  std_logic;
        posicion_pantalla: out std_logic_vector(14 downto 0);
        win: out std_logic;
        level1: in  std_logic;
        level2: in  std_logic;
        level3: in  std_logic
    );
end pantalla_principal;

architecture Behavioral of pantalla_principal is

    type pantalla_states is (state0, state1, state2);
    signal pantalla_state: pantalla_states := state0;
    signal active_level: integer range 0 to 3 := 0;
    signal win_flag: std_logic := '0';
    constant PARED_SEG: std_logic_vector(6 downto 0) := "1001111";
    constant PARED_DISP: std_logic_vector(7 downto 0) := "11101111";

begin

-- selección de nivel 
active_level <= 1 when level1 = '1' else
                2 when level2 = '1' else
                3 when level3 = '1' else
                0;

    -- FSM principal
process(clk, reset)
    begin
        if reset = '0' then
            pantalla_state <= state0;
            win_flag <= '0';

        elsif rising_edge(clk) then
            case pantalla_state is
                when state0 =>
                    win_flag <= '0';
                    pantalla_state <= state1;
                when state1 =>
                    pantalla_state <= state2;
                when state2 =>
                    if active_level /= 0 then
                        win_flag <= '1';
                    end if;
                    pantalla_state <= state2; -- se queda en victoria
            end case;
        end if;
    end process;

    -- pared fija
    posicion_pantalla <= PARED_DISP & PARED_SEG;
    win <= win_flag;
    
 end Behavioral;
