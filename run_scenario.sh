#!/bin/bash
# jp_taito 0,-120,90,1.2,0.6
# cz_zlin 130,20,45,2.5,0.6
# us_coldwater0,-120,90,1.2,0.6
# Check if an argument is given
if [ -z "$1" ]; then
  echo "Usage: $0 <filename.xosc>"
  exit 1
fi
SCENARIO_PATH="$1"

case "$SCENARIO_PATH" in
    *jp_taito*)
        params_string="0,-120,90,1.2,0.6"
        ;;
    *cz_zlin*)
        params_string="130,20,45,2.5,0.6"
        ;;
    *us_coldwater*)
        params_string="0,-120,90,1.2,0.6"
        ;;
    *)
        # Default or fallback parameters if none of the above match
        echo "Warning: Unknown location in SCENARIO_PATH. Using default params."
        params_string="0,0,0,1.0,1.0"
        ;;
esac
# Run esmini with the given .xosc file
# Execute the final command with the determined parameters
echo "Running esmini for $SCENARIO_PATH with params: $params_string"

app/esmini_visualizer_app/esmini-demo/bin/esmini \
    --window 60 60 1200 800 \
    --osc "$SCENARIO_PATH" \
    --custom_fixed_camera "$params_string"