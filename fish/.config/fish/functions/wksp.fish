function wksp --description 'WofStack workspace manager (wksp help for usage)'
    # Always delegate to the script in w1/tools/ so the fish function
    # never needs to be updated when the CLI gains new features.
    ~/localdev/wofstack/tools/wksp $argv
end
