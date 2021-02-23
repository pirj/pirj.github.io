In search for an ideal 40% programming keyboard layout

## Why?

It may sound like a lockdown project/article, but it's not.

While working on a laptop that was heating up my palms, and having an incomfortable position, wrist pain developed. It's not that bad or frequent, but I can feel it sometimes.

Since then, I felt in love with mechanical keyboards, but kept working on a daily basis on a MacBook.

Now is the time. I've purchased a GerfoPlex, an ergonomic 40% split ortholinear mechanical keyboard with low-profile keys, the best money can buy.

Computer keyboards were originally designed after typewriter keyboards. This was not such a good idea, but we have to deal with this legacy. You may see the traces in key naming, e.g. <carriage> return, tab<ulation>, <carriage> shift.

Typewriters were heavy, and so were the keys. It took a significant effort to print, as you were effectively pressing the lever with a letter hammer stroke the ink ribbon and left an imprint of that letter on the paper.

To avoid hammers hitting each other and getting stuck, the keys were shifted vertically.

There is nothing about ergonomics, or better be said user happiness, in this design. And it doesn't have to be this way anymore.

## What does this all mean?

40% means it only has that much keys out of 104 traditional keys. That would mean it had 41 keys, but it actually only has 36. "What?" - you would say, "how is it even possible to use it?". It is possible. And it's more comfortable than you could even imagine. Bear with me, an you'll figure it out.

Staggered means that keys in different rows are not aligned. But your fingers move up and down when you bend and unbend them. Meaning you also have to shift your fingers to hit the right key. But try to shift your finger while it's bent. So you also urged to move your hands when typing. While you're at it, try to bend your pinkie without bending the ring finger.

Ortholinear means the opposite, keys in different rows are aligned.

Split means there are two halves of that keyboard. Keeping your palms together doesn't make a comfortable sitting position. Put them apart and feel the relaxation in your shoulders.

Low-profile key switches reduce the height of the keyboard. The less the height of the keyboard - the less you bend your palms. No wrist rest needed for a low-profile keyboard.

Fingers all have different lengths, where pinky is the shortest one. To make the keys more reachable for different fingers, key columns are shifted against each other.

Last, but not least, palm angle. Palms down is not a neutral position. Neither is rotated by 90 degrees, like holding a cup. Neutral is somewhere in between. Some prefer to use tents to keep palms in that neutral position. But in this case they can't rest on the surface. So there's a trade-off.

## Layout

So, ortholinear, split, 40%, vertically shifted is all about the physical layout of the keys.

How symbols are mapped to that keys is a functional layout. Traditional QWERTY comes from a ... you guessed it right, a typewriter. It dates back to year 1878. Yes, it's your granddad's grandad's layout. It has not much of a human-oriented design behind it. But still, we use it.

Typewriters were used by writers and journalists. But now, they are used mostly to post to social networks. Some weirdos like me are using it for software development.

Is QWERTY bad? Not really. Unless you're already typing at a blazing speed and some frequently used keys are too far to reach, and this is holding you back from the new typing speed world record. Which is 1280 characters per minute. 21 per second. My typing speed is about ten times slower than that.

## 40% functional layout

To map all symbols for everyday use to a limited number of keys, layers are used. You are using layers already. Shift is a layer that has capital letters. If you're on macOS, Option is a layer for special symbols, too.

Here is the [default functional layout for GergoPlex](https://github.com/qmk/qmk_firmware/blob/15f90ac78da78d8a15e862555bf2390981ad84b0/keyboards/gboards/gergoplex/keymaps/default/keymap.c#L31):

Basic layer
,------------------------------.    ,------------------------------.
|    Q |  W  |  E  |  R  |  T  |    |  Y  |  U  |  I  |  O  |   P  |
|------+-----+-----+-----+-----|    |-----+-----+-----+-----+------|
|CTRL/A|  S  |  D  |  F  |  G  |    |  H  |  J  |  K  |  L  |CTRL/;|
|------+-----+-----+-----+-----|    |-----+-----+-----+-----+------|
|SHFT/Z|  X  |  C  |  V  |  B  |    |  N  |  M  |  <  |  >  |SHFT/?|
`------------------------------'    `------------------------------'
  .-------------------------.          .-----------------.
  |ESC/META|ENT/ALT|SPC(SYM)|          |SPC(NUM)|BSPC|TAB|
  '-------------------------'          '-----------------'

Where is the Escape key, you ask? No Escape, haha! And no Backspace either!
There's another technique, that I got used to very, very quickly, called combos. Also, they are typically known as chords and are the core of stenography.
Pressing S and D together results in Backspace. Pressing W and E together - in Escape. So WE escape! To confirm it, U and I together also results in Escape.

Combomap
,-----------------------------.      ,-----------------------------.
|     |  Escape   |     |     |      |     |  Escape   | Backslash |
|-----+-----+-----+-----+-----|      |-----+-----+-----+-----+-----|
|     | Backspace |     |     |      |     |     |     |     |     |

Just in case, there's a Symbols layer with all the symbols you ever need for software development (in Ruby). Symbols layer is activated by depressing (pressing and holding, like you do with Shift) the left thumb key.

Symbols layer
,-----------------------------.      ,-----------------------------.
|  !  |  @  |  {  |  }  |     |      |  ~  |     |     |  \  |     |
|-----+-----+-----+-----+-----|      |-----+-----+-----+-----+-----|
|  #  |  $  |  (  |  )  |     |      |  +  |  -  |  /  |  *  |  '  |
|-----+-----+-----+-----+-----+      |-----------------------------|
|  %  |  ^  |  [  |  ]  |     |      |  &  |  =  |  ,  |  .  |  -  |
`-----+-----+-----+-----+-----'      `-----------------------------'

You would ask, how does that biggest left thumb key work. It works a modifier that switches to the Symbol layer, and it's a Space when pressed on its own.
This trick is well known by those who use Vim and hate stretching to the physical Escape key. In Vim world tools like `xcape` (on Linux) and Karabiner Elements (on macOS) map Escape to a single press on CapsLock, and Control to a long press on it.
Nothing really new, but it comes very handy for a keyboard with so few keys on it.

There is a Number layer, too, if you forgot how many keys are left to map. It's activated by depressing the right biggest thumb cluster key.

Number layer
,-----------------------------.      ,-----------------------------.
|  1  |  2  |  3  |  4  |  5  |      |  6  |  7  |  8  |  9  |  0  |

There are F1-F12 keys on it, too. And arrow keys, and additionally media keys that are present only on select multimedia (is there still such a word?) keyboards.

That's all of them symbols and keys.

## Typing fatigue

(not yet reading fatigue, I hope!)

Typing fatigue is caused by:
 - hand movement
 - finger bending
 - finger travel
 - neck strain of looking at the keyboard and back at the screen (unless you are always bending your neck to your laptop on your lap, which is even worse)

To reduce neck strain, a typing technique called touch typing exist. Basically, you use your muscle memory and don't look at the keys.

To address other problems, people go on a quest for a perfect keyboard layout. Every one has their own ideal keyboard layout. Even programmers in different programming languages do.

You've probably heard of Dvorak and Colemak layouts. But there are more than just those two, many more.

I'm a Ruby developer, and sometimes I write regular text. I'll go on my own quest for an ideal 40% functional keyboard layout, too, and invite you to follow me in this adventure.

## Penalty factors

A penalty is the result of an effort. Penalty incrementally adds to fatigue and pain in the end of the (working) day.

A comprehensive research on this topic is carried out [here](http://mkweb.bcgsc.ca/carpalx/?typing_effort).

I can only add from myself that key combinations are hard. Have you ever tried pressing Command+Control+Shift+4 to take a screenshot of a portion of the screen and copy it to the clipboard?

## Starting point

Now I own this perfect keyboard. I'm not a perfect touch typist, I move my hands a lot when using a regular (laptop) keyboard, and I mostly type with my index and middle fingers. Also, by left thumb. Left thumb is very import as you'll see later.

I develop mostly in Ruby. It's a specific language that uses alphabetical symbols mostly, and it's really easy to write (and read).

All researches have been conducted, all tools have been created. So I'm only left to stand on the titan's shoulders and feed my input and constraints to the existing tools. Doesn't sound too hard.

I live in the console, and leave it quite rarely. Still using the web version ofGMail, but probably not for long with [aerc](https://aerc-mail.org/) becoming mature. Quick web searches, translation between languages, (self-)time tracker, ToDo lists, audio player, I use the terminal for all of that. Tmux, Vim and pure command-line tools are my daily drivers.
It's not only faster, more importantly the lag is significantly lower. And so it the cognitive penalty. While the satisfaction is higher.

Also, I refrain from using the mouse/touchpad unless absolutely necessary. I know of trackballs and vertical ergonomic mice, but it's not my thing.

## Constraints

There's problem though, if the keyboard breaks, I'm left out with a laptop keyboard and QWERTY. And it will be too hard to use something that dates back from 1878 when I got used to this comfort.

This is the main reason I'm trying to avoid existing layouts is that the differences with QWERTY are immense, sometimes for little benefit.

Another constraint is that even though HJKL keys are not the most used keys, I use them a lot, since I use Vim (I know, there are better ways to navigate the text), and most importantly other tools with Vim-like mappings, e.g. GMail, vimpc.

A physical constraint to add to the mix is that I have short pinkies. Or normal pinkies, but long other fingers, depending on how you see it. So I would prefer not to stretch my pinkies, nor to bend them. That is getting radical as hell, but I'd love to only keep one key for each pinkie. Or two keys for each of the pinkies and ring fingers.
That makes a total of 32 keys.

## Layout configuration

So, you are probably wondering where are those settings and checkboxes in your operating system of choice, and how are they (XKB on Linux and Karabiner Elements on macOS) compatible with each other. Worry not. It's a programmable keyboard, like many other enthusiast keyboards. So, you can change those layouts and upload the changes to the keyboard by using the same cable that is used to connect it to the computer.

The software library, tools and a huge collection of layouts for an incredible amount of keyboards is called [QMK firmware](https://github.com/qmk/qmk_firmware).


## References

[Carpalx, keyboard layout analysis and optimization](https://mkweb.bcgsc.ca/carpalx/)

[Carpalx layout analysis for 36-keys keyboards](https://www.reddit.com/r/olkb/comments/e0p3lg/using_carpalx_to_evaluate_qmk_keymaps_and/)

[Accompanying software analyzer](https://github.com/jackhumbert/typing_model)

[Another layout analysis for 36-keys keyboards](https://mull.in/2018/04/08/qwerty-alternate-ergo/)

[BEAKL theory and layouts](https://deskthority.net/wiki/BEAKL)

[Gotta go fast, a terminal utility for practicing typing](https://github.com/callum-oakley/gotta-go-fast)

[US keyboard enthusiast community](https://geekhack.org/)

[EU keyboard enthusiast community](https://deskthority.net/)

[GergoPlex keyboard](https://www.gboards.ca/)

[Everything about keyboards from a keyboard guru](http://xahlee.info/)

[tmux multi-key bindings](https://superuser.com/questions/446721/tmux-bind-key-with-two-keys/1265657#1265657)

[34-key functional layout](https://github.com/1MachineElf/qmk_firmware/tree/master/keyboards/acheron/shark/keymaps/sb4dv)
