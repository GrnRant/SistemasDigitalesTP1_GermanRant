library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library work;
use work.semaforos_states.all;

entity counter_semf is
    generic (
        N_SEMF : natural := 5;
        N_SEG_COUNTER : natural := 26);
    port (
        ena_semf_counter : in std_logic;
        clk_semf_counter : in std_logic;
        rst_semf_counter : in std_logic;
        state : in semf_states;
        qo_semf_counter : out std_logic_vector(N_SEMF - 1 downto 0);
        max_semf_counter : out std_logic
    );
end counter_semf;

architecture counter_semf_beh of counter_semf is
    signal aux : unsigned(N_SEMF - 1 downto 0);
    signal qo_seg : std_logic_vector(N_SEG_COUNTER - 1 downto 0);
    signal add : std_logic;
    constant T1: integer := 30;
    constant T2: integer := 3;

begin
    COUNTER_INST : entity work.counter(counter_beh)
        generic map(N => N_SEG_COUNTER)
        port map(
            ena => ena_semf_counter,
            clk => clk_semf_counter,
            rst => rst_semf_counter,
            qo => qo_seg,
            max => add
        );

    P_CLK : process (clk_semf_counter, rst_semf_counter)
    begin
        --Si reset está activado
        if rst_semf_counter = '1' then
            aux <= (others => '0');
        end if;
        if rising_edge(clk_semf_counter) then
            --Si está habilitado
            if ena_semf_counter = '1' then
                if state = E0 or state = E3 then
                    if aux = to_unsigned(T1, N_SEMF) then
                        aux <= (others => '0');
                        max_semf_counter <= '1';
                    else
                        if add = '1' then
                            aux <= aux + 1;
                        end if;
                        max_semf_counter <= '0';
                    end if;
                else
                    if aux = to_unsigned(T2, N_SEMF) then
                        aux <= (others => '0');
                        max_semf_counter <= '1';
                    else
                        if add = '1' then
                            aux <= aux + 1;
                        end if;
                        max_semf_counter <= '0';
                    end if;
                end if;
            end if;
            qo_semf_counter <= std_logic_vector(aux);
        end if;
    end process P_CLK;

end counter_semf_beh;

