self: super: {
    bspwm = super.bspwm.overrideAttrs (old: {
        patches = (old.patches or []) ++ [
          (super.fetchpatch {
              url = "https://github.com/j-james/bspwm-rounded-corners/commit/00e85df0505d2bfbd41234d1daf2f03c461b6a2b.patch";
              sha256 = "kZjwsGxEWrwDEoaNlE0JigPaN63+2k1px+Frzfw4toQ=";
            })
        ];
      });
  }
