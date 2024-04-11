-- https://www.reddit.com/r/pipewire/comments/10smi87/how_to_change_sampling_rate_and_bit_depth/
alsa_monitor.enabled = true

-- This rule is to instantly use DAC right after connected
switch_to_dac = {
    matches = {{{"node.name", "matches", "alsa_output.DEVICE_NAME"}}},
    apply_properties = {
        ["priority.session"] = 10000,
        ["audio.rate"] = 96000,
    }
}

table.insert(alsa_monitor.rules, switch_to_dac) 