library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library work;
use work.semaforos_states.all;

entity semaforos is
    port (
        clk_semf : in std_logic;
        rst_semf : in std_logic;
        ena_semf : in std_logic;
        green1 : out std_logic;
        yellow1 : out std_logic;
        red1 : out std_logic;
        green2 : out std_logic;
        yellow2 : out std_logic;
        red2 : out std_logic);
end semaforos;

architecture semaforos_beh of semaforos is
    signal current_state : semf_states;
    signal event : std_logic;
begin
    COUNTER_SEMF_INSTANCE : entity work.counter_semf(counter_semf_beh)
        port map(
            ena_semf_counter => ena_semf,
            rst_semf_counter => rst_semf,
            state => current_state,
            max_semf_counter => event,
            clk_semf_counter => clk_semf);

    P_SEMF_FSM : process (clk_semf, rst_semf)
    begin
        --Si reset activado volver al estado inicial
        if rst_semf = '1' then
            current_state <= E0;
        end if;

        if rising_edge(clk_semf) then
            if ena_semf = '1' then
                if event = '1' then
                    C_SEMF : case current_state is
                            --E0 => E1
                        when E0 =>
                            current_state <= E1;

                            --E1 => E2
                        when E1 =>
                            current_state <= E2;

                            --E2 => E3
                        when E2 =>
                            current_state <= E3;

                            --E3 => E4
                        when E3 =>
                            current_state <= E4;

                            --E4 => E5
                        when  E4 =>
                            current_state <= E5;

                            --E5 => E0
                        when E5 =>
                            current_state <= E0;
                        when others =>
                    end case C_SEMF;
                end if;
            end if;
        end if;
    end process P_SEMF_FSM;

    --Asignación de luces dependiendo del estado actual
    --Semáforo 1
    red1 <= '1' when (current_state = E0 or current_state = E1 or current_state = E5) else '0';
    yellow1 <= '1' when (current_state = E2 or current_state = E4) else '0';
    green1 <= '1' when current_state = E3 else '0';
    --Semáforo 2
    red2 <= '1' when (current_state = E2 or current_state = E3 or current_state = E4) else '0';
    green2 <= '1' when current_state = E0 else '0';
    yellow2 <= '1' when (current_state = E1 or current_state = E5) else '0';


end semaforos_beh;