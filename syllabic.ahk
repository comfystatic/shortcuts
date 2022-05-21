#SingleInstance Force
#Persistent
#NoEnv

SendMode Input


Space::
    Input UserInput

    Switch UserInput
    {
    ; A A A A A A A A A A
    case "ab": Send, about

    case "al": Send, all

    ; B B B B B B B B B B
    case "b": Send, be
    case "bn": Send, been
    case "bng": Send, being

    ; C C C C C C C C C C
    case "c": Send, see
    case "cd": Send, could
    case "cdn": Send, couldn't
    case "cn": Send, can
    case "cnn": Send, cannot
    case "cnt": Send, can't

    ; D D D D D D D D D D
    case "d": Send, do
    case "dn": Send, don't
    case "dd": Send, did
    case "ddn": Send, didn't
    case "ds": Send, does
    case "dsn": Send, doesn't
    case "dn": Send, done
    case "dng": Send, doing

    ; F F F F F F F F F F
    ; case "f": Send, for
    case "f": Send, of
    case "fwd": Send, forward

    case "gt": Send, get
    case "gts": Send, gets
    case "gtg": Send, getting

    case "h": Send, the
    ; H H H H H H H H H H
    case "hv": Send, have
    case "hd": Send, had
    case "hs": Send, has
    case "hvg": Send, having

    case "hr": Send, here
    case "hy": Send, hey
    case "hw": Send, how

    ; I I I I I I I I I I
    case "ii": Send, Ida

    case "i": Send, I
    case "id": Send, I'd
    case "im": Send, I'm

    ; J J J J J J J J J J
    case "j": Send, just

    ; K K K K K K K K K K
    case "k": Send, okay

    case "kn": Send, know
    case "knn": Send, known
    case "kns": Send, knows
    case "kng": Send, knowing
    case "knw": Send, knew

    ; L L L L L L L L L L
    case "lt": Send, let
    case "lts": Send, lets
    case "lt'": Send, let's

    ; M M M M M M M M M M
    case "m": Send, am

    ; N N N N N N N N N N
    case "n": Send, an

    case "nt": Send, not

    case "nc": Send, nice
    case "ncr": Send, nicer
    case "ncs": Send, nicest

    case "nu": Send, new
    case "nur": Send, newer
    case "nus": Send, newest

    case "nd": Send, need
    case "ndd": Send, needed
    case "nds": Send, needs
    case "ndg": Send, needing

    case "ng": Send, night
    case "ngs": Send, nights

    case "nm": Send, name
    case "nms": Send, names

    case "nw": Send, now
    case "nv": Send, never

    ; O O O O O O O O O O
    case "o": Send, oh

    ; R R R R R R R R R R
    case "r": Send, are
    case "rn": Send, aren't

    case "rt": Send, right

    ; S S S S S S S S S S
    case "s": Send, so

    ; T T T T T T T T T T
    case "t": Send, it

    case "ts": Send, this
    case "tt": Send, that
    case "ths": Send, those
    case "thr": Send, there

    ; U U U U U U U U U U
    case "u": Send, you
    case "uu": Send, your
    case "ur'": Send, you're
    case "uv": Send, you've

    ; V V V V V V V V V V
    case "v": Send, 've
    case "vr": Send, very

    ; W W W W W W W W W W
    case "w": Send, we
    case "wr'": Send, we're
    case "wv'": Send, we've
    
    case "wh": Send, who
    case "wht": Send, what
    case "whn": Send, when
    case "whr": Send, where

    case "wn": Send, went

    case "wnt": Send, want

    case "wt": Send, with

    case "wr": Send, were
    case "wrn": Send, weren't
    case "ws": Send, was
    case "wsn": Send, wasn't

    case "wt": Send, want
    case "wts": Send, wants
    case "wntd": Send, wanted
    case "wntg": Send, wanting

    ; Y Y Y Y Y Y Y Y Y Y
    case "y": Send, why

    ; Z Z Z Z Z Z Z Z Z Z
    case "z": Send, is
    case "zn": Send, isn't
    
    ; # # # # # # # # # #
    case "2": Send, to
    case "22": Send, too
    case "4": Send, for
    case "=": Send, and
    case ",": Send, {BackSpace} ,
    case "'": Send, 's
    case "7": Send, and

    Default: Send % UserInput
    }

    Send,{Space}

    return

~Space Up::Input

