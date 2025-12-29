library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity contador is
    Port (
        clk : in  std_logic;
        rst : in  std_logic;
        level1 : in  std_logic;
        level2 : in  std_logic;
        level3 : in  std_logic;
        manzanas : in  std_logic_vector(14 downto 0);
        pos_persona : in  std_logic_vector(14 downto 0);
        unidades_s : out std_logic_vector(3 downto 0);
        decenas_s : out std_logic_vector(3 downto 0);
        game_over_s  : out std_logic;
        win_s : out std_logic;
        nivel1_act : out std_logic;
        nivel2_act : out std_logic;
        nivel3_act : out std_logic
    );
end contador;

architecture Behavioral of contador is

    signal score_count : integer range 0 to 99 := 0;
    signal bottom_prev : std_logic := '0';
    signal l1_prev, l2_prev, l3_prev : std_logic := '0';
    signal active_level : integer range 1 to 3 := 1;
    signal target_score : integer range 0 to 99 := 10;
    signal win_i : std_logic := '0';
    signal game_over_i : std_logic := '0';

begin

    process(active_level)
    begin
        case active_level is
            when 1 => target_score <= 10;
            when 2 => target_score <= 15;
            when 3 => target_score <= 20;
            when others => target_score <= 10;
        end case;
    end process;

    nivel1_act <= '1' when active_level = 1 else '0';
    nivel2_act <= '1' when active_level = 2 else '0';
    nivel3_act <= '1' when active_level = 3 else '0';

    process(clk, rst)
        variable same_display : std_logic;
        variable bottom_now   : std_logic;
        variable bottom_pulse : std_logic;
        variable l1_pulse, l2_pulse, l3_pulse : std_logic;
    begin
        if rst = '0' then
            score_count <= 0;
            win_i <= '0';
            game_over_i <= '0';
            bottom_prev <= '0';
            l1_prev <= '0'; l2_prev <= '0'; l3_prev <= '0';
            active_level <= 1;

        elsif rising_edge(clk) then
            l1_pulse := level1 and (not l1_prev);
            l2_pulse := level2 and (not l2_prev);
            l3_pulse := level3 and (not l3_prev);
            l1_prev <= level1;
            l2_prev <= level2;
            l3_prev <= level3;
            
            if l1_pulse = '1' then
                active_level <= 1;
                score_count  <= 0;
                win_i        <= '0';
                game_over_i  <= '0';
                
            elsif l2_pulse = '1' then
                active_level <= 2;
                score_count  <= 0;
                win_i        <= '0';
                game_over_i  <= '0';
                
            elsif l3_pulse = '1' then
                active_level <= 3;
                score_count  <= 0;
                win_i        <= '0';
                game_over_i  <= '0';
            end if;

            if manzanas(3) = '0' then
                bottom_now := '1';
            else
                bottom_now := '0';
            end if;

            bottom_pulse := bottom_now and (not bottom_prev);
            bottom_prev  <= bottom_now;

            same_display := '0';
            for i in 0 to 4 loop
                if (pos_persona(7+i) = '0') and (manzanas(7+i) = '0') then
                    same_display := '1';
                end if;
            end loop;

            if (win_i = '0') and (game_over_i = '0') then
                if bottom_pulse = '1' then
                    if same_display = '1' then
                        if score_count < 99 then
                            score_count <= score_count + 1;
                        end if;
                    else
                        game_over_i <= '1';
                    end if;
                end if;
            end if;

            if (win_i = '0') and (score_count >= target_score) then
                win_i <= '1';
            end if;

        end if;
    end process;

    unidades_s <= std_logic_vector(to_unsigned(score_count mod 10, 4));
    decenas_s  <= std_logic_vector(to_unsigned(score_count / 10, 4));
    win_s <= win_i;
    game_over_s <= game_over_i;
    
    end behavioral;