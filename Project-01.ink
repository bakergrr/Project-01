VAR time = -1
VAR mood = 0
// measures friend's mood. 0 is the baseline - happy to be seeing the stars, comfortable, a little wistful. positive = positive emotion, negative = negative emotion
VAR bracelet_time = 999
VAR bracelet_colors_nice = 0
~ bracelet_colors_nice = RANDOM(0,1)
VAR have_bracelet = 0
// 1 = you have taken the bracelet from your friend
VAR final_option = 0
// the way i want to do this is that when time reaches 9 or 10, you get ONE MORE option before we trigger the ending.
 -> beginning
 
== function advance_time(t) ==
~ time += t
~ return time
== function advance_bracelet() ==
{bracelet_time > 0 and bracelet_time != 999:
~ bracelet_time -= 1
}
//~ return bracelet_time
== function change_mood(m) ==
{ mood < m:
    ~ mood = m
- else:
    ~ mood += m
}
== function decay_mood() ==
/* - i originally wanted the mood to return to zero over time so that it wouldn't last forever, but i don't know that this game is long enough for it to matter.
{ mood < 0:
~ mood += 0.5
}

{ mood < -1:
~ mood += 0.5
} */
~ return

== beginning ==
You're sitting on the roof. They are too, gazing up at the stars with the rapt wonder they never truly seemed to lose. The two of you have seen these stars a hundred times, and you've seen the same sparks in their eyes, joy in the corners of their mouth, gears turning in their brain a hundred times, too.

...A hundred and one, you correct yourself. It was your idea to end on 101 before they left. It felt like a nice number. But there's so much you need to say, and all before the sun comes up. Before they go off to school and leave you in this middle-of-nowhere town.

* [Look at the {final_option == 0:stars|sunrise}.]
-> stars

== stars ==
{final_option == 1: -> goodbye}
You take your eyes off of your friend and look back up at the stars.
{advance_time(1)} {advance_bracelet()}
{time<=2:The sky is still dark and the stars holes poked in paper, letting light through from behind.}
{time==3: You think you see a shooting star in the sky! ...It's an airplane.}
{time==4: A few hours have passed since you first got here. The moon is so, incredibly bright in the sky.}
{time==5: The moon, gleaming bright, is starting to fall from its peak.}
{time==6: Night winds rush by, their coldness seeming to pierce through you. The moon is setting.}
{time==7 or time==8: You can see a tinge of light on the horizon. Time is running out, and you plead it to flow just a little bit slower.}
{time >= 9: Morning has come. Your heart falls as the sun rises. It's almost time for your your friend to go, and the thought of it breaks your heart. But still, you try to keep composure and enjoy what precious little time you have left.}
{time >= 9:
~ final_option = 1
}

<>{mood<0:{~ You feel their eyes on you, careful, cautious. You pretend you don't.| The silence feels different now.| You hear a sigh.}}
{mood>0:{~ You can feel your friend's knee bouncing fast. It's a happy fidget, you think.| You hear your friend joyfully hum some tune you don't recognize. | You can practically feel your friend's smile from here.}} 
{time <=4:{not constellation.cassiopeia && not constellation.aquila:<> You think you see that constellation they always look for, but you forget the name.|<> You notice {constellation.cassiopeia:Cassiopeia}{constellation.aquila:Aquila} in the sky{not mood < 0: and smile}.}}
{bracelet_time != 999 and bracelet_time >0:{mood<0: Your friend is... still working on your bracelet, using it to occupy their hands.| Your friend is happily working on your bracelet. {bracelet_time == 1:It's almost done!}}}{bracelet_time <=0: The bracelet is done!{mood<0: Your friend isn't really sure what to do with it, so they just kinda fidget.| They hold it out triumphantly!}}

There's so much you want to say...
* "Are you gonna forget me when you leave?"
-> forget
* {time <=4}"What's the name of that constellation you're always looking for?"
-> constellation
* "What's the first thing you're gonna do when you get out there?"
-> first_thing
* "What's your family gonna do without you?"
-> family
* {bracelet_time==0}"Oh, you finished the bracelet{mood<0:.|!}"
-> braceletfinished
+ {mood<0}"I'm sorry."
-> apology
+ Sit in silence.
    {advance_time(1)} You sit there, trying to think of the right words to say. None come to mind. But the sky is beautiful, and maybe you could take a few pointers from your friend and actually look at it.
    ++ [Look at the {final_option == 0:stars|sunrise}.]
    -> stars
- -> DONE

== constellation ==
They look over at you, try to see what you're seeing? "Oh, which one?"
* "Y'know, the one that..."
** "looks like a W?"
-> cassiopeia
** "looks kinda like a bird?"
-> aquila
= cassiopeia
"You mean Cassiopeia? I don't always look for it, though. I mostly just try and point it out to you."
* "Why?"
    "Because it's an easy shape to figure out. Like you said, it's a W, right? I know you don't know much about constellations n' stuff, but I wanted to give you something you could look for. So we had something we could look at together."
    God, they're the best. 
-> followup
= aquila
"Oh, Aquila? Yeah! It's got some cool symbolism of its own, but I think it's a little interesting that... I dunno if you can see Altair from here? It's... there."
You can't.
"It's part of the Summer Triangle!"
* "That's... a different constellation?"
    "Not exactly, but it IS an asterism. Like, a group of stars. Altair, Deneb, Vega, all the brightest stars of their contellations. The three stars are important in ceremony, navigation, myth. I think it's neat!
    -> followup
= followup
    +[Look at the {final_option == 0:stars|sunrise}.]
    -> stars
* "You gonna tell me my horoscope?"
    {advance_time(1)}
    They roll their eyes but keep smiling.
    "No. That's boring. This is more fun."
    Guess that's sorted, then.
* {cassiopeia}"Why not the Big Dipper?"
    {advance_time(1)}
    "Everyone knows how to look for the Big Dipper. It's just... kinda there?"
    You don't, but you won't let them know that.
* (randomtriangle){aquila}"All that for a random triangle?"
    {advance_time(1)}
    They smile, and you hear it before it comes. "YOU'RE a random triangle."
* (reallylikeit)"You really like this stuff, don't you?"
    {advance_time(1)}
    "YES." You can see their eyes light up, and then they're off, knees bouncing and hands twitching with joy. 
    "I mean, I think everyone should. Like, think about it for a minute! All of these supermassive giant balls of gas, so incredibly bright and dense and hot that we couldn't even imagine it, some further away than any of us could travel in a lifetime, and we can see them! And they're in this position because we're watching them on this specific day, on this specific spot, in this specific moment."
    ** "Yeah!"
        {change_mood(1)}
        {advance_time(1)}
        "And, and! We're not even seeing them how they are. It takes so, so incredibly long for the light from these stars to reach our eyes. Y'know Polaris? The North Star? We're seeing it 433 years in the past. We are LITERALLY seeing back in time!"
        You let them keep going - this isn't the first time you've heard this, and you know you're losing precious time together, but... god, this is the last time you're going to hear them say it, isn't it?
        - + [Look at the {final_option == 0:stars|sunrise}.]
    -> stars

== forget ==
"What?" They turn to you, eyes wide with worry. "Why would you think that?"
Oh, no. Oh, no, what did you do? Quick, they're expecting an answer.
* "It's just, uh... you're gonna be so far away, and somewhere so much bigger, y'know? You're gonna make a ton of new friends."
-> honest
* "Sorry, sorry! I just meant, like... you forget to put both shoes on when you left the house yesterday."
-> joke
* "Nothing, nothing, nevermind."
-> dodge
= honest
You regret saying that. They take one breath in and one long breath out and then take your hands.
* "What?"
{advance_time(1)}
    "Look, okay, I want you to know I'm not gonna forget you. That'd be like forgetting my mom. I would die. You would die. Lotsa carnage. Genuinely, I would never. Do you want me to, like, set a reminder in my phone? Would that help?"
    ** "No, it's okay. You saying this helps."
    It really does. God, you love them.
    *** "...Thank you."
        "Anytime, seriously," they say, expression warm but still serious. They let go of your hands, then, and stare back up at the sky.
        ++++ [Look at the {final_option == 0:stars|sunrise}.]
        -> stars
= joke
For a second, you can see that they're still concerned, but then they smile. "HAH! Yeah, I guess you're right. But that's why I need YOU, y'know? You think I'm suddenly gonna become the productive one overnight?"
 * "Yeah, I guess you're right. What would you do without me?"
 "Probably not much," they say, and then turn back to the sky.
 ++ [Look at the {final_option == 0:stars|sunrise}.]
 -> stars
= dodge
{change_mood(-1)}
They're not buying it. "...Okay. Um. If you're sure." They turn back to the stars, still a little unsatisfied.
+ [Look at the {final_option == 0:stars|sunrise}.]
-> stars

== first_thing ==
"Ooh, tough one." They grin, thinking for a moment. "Eh. Probably sleep."
* "Really? First thing you're gonna do is sleep?"
    "Yup." They look a little too satisfied with themself. You probably should've expected it.
    ** "Okay, then first thing AFTER you sleep?"
        "...I don't know. Can... can we talk about something else? I don't wanna think about it right now."
        *** "Yeah, of course. Like what?"
        -> let_go
        *** "What's wrong?"
        -> push
= push
"I don't want to talk about it." There's an edge in their tone.
* "Sorry. We can talk about something else."
{advance_time(1)}{change_mood(-0.5)}
    "Thanks. How about, uhhh... -> let_go
* (prytoofar)"How am I supposed to help if you won't tell me what's wrong?"
    "I don't want you to help. I want you to change the subject."
    ** "I-"
        "Stop." There are barbs in their words strong enough to cut diamonds.
        {change_mood(-1)} {advance_time(1)}
        **** "..."
            "..."
            ***** "Sorry. I'm sorry."
            "It's fine. You're fine. I'm sorry, too."
            ++++++ [Look at the {final_option == 0:stars|sunrise}.]
            -> stars
-> END 
= let_go
{not push: "Uhh... <>}
{push:"}Oh! Oh, I know! I've been making these friendship bracelets, see?"
They extend out their wrist, revealing a colorful bracelet made from colored thread... embroidery thread? You forget the term.
* "Oh, look at that! How d'you make them?"
{advance_time(1)}
    "It's all knots! You take embroidery floss, and you put in a loom - I just used a clipboard - and then you tie a million knots in a pattern. I actually brought my stuff up here in case I needed to fiddle with something."
    
    Before you can stop myself, you ask,
    ** "Could you make me one?"
    {change_mood(1)}
    "I was just thinking the same thing!" they shout, eyes locked with yours.
    They take out a repurposed tackle box and a clipboard and take out several colors of embroidery floss. They hold them out to you. "Pick three!"
    You can't tell any of them apart in the dark.
    *** "Uhh... this one, this one, and that one."
        You point to three random colors and hope they make sense together. "Got it! {bracelet_colors_nice == 1:These're gonna look really nice, good eye!"|This... might look weird, but we'll make it work."} Soon enough, they've got everything set up and have started tying infinitesimal knots.
        ~ bracelet_time = 2
        ++++ [Look at the {final_option == 0:stars|sunrise}.]
        -> stars
/* == sleep ==
You take your eyes off of your friend and notice... they're getting heavy. You wanted to spend all night stargazing, but... maybe some sleep wouldn't be the worst thing in the world. Before you even realize it, you've fallen asleep on your friend's shoulder. You aren't awake to notice, but they don't seem to mind. This is nice.
-> END 
*/

== family ==
"They'll be fine. It'll be a lot for them - for all of us, I guess - at first. Mama'll text me, like, 50 times a day, and Mom'll send cat pictures and pretend Mama told her to. And Jo's... god, Jo's a wildcard, I dunno with her."
* "Gonna be a hell of a lot less whimsical without you."
-> whimsical
* "Do you and Jo still play that one game together? You gonna keep playing?"
-> game

= whimsical
"Yeah it is." They sigh dramatically and flop down, laying against the roof. "Mama's gonna try her best, but soon the house will succumb to Mom's plaid and Jo's grey. Truly a horrible fate."
{advance_time(1)}
* "Jo's not gonna take over your half of the room, is she!?"
    They put their hand on your shoulder for dramatic effect.
    "In. A. Heartbeat, my friend."
    You try not to think about the way your heart leaps at the contact.
    ** "NO."
    "YES."
    *** "NO!!!"
    "YES!!!"
    **** "But your string lights! Your beanbag chair! Your rug!!"
    "A necesary sacrifice. I'll rebuild, with more whimsy than ever before, once I move in. I promise you this."
    ***** "I'll hold you to your word, soldier."
    They snicker and break character. "God, I'm gonna miss this." {advance_time(1)}{change_mood(1)}
    You're going to miss this, too.
    ++++++ [Look at the {final_option == 0:stars|sunrise}.]
    -> stars
= game
"What, you mean Battle Critters VII? Yeah, of course! It's my favorite game ever, and Jo is just as obsessed. I think she'd come with me if it meant we could play more, hah." They look at you like this should've been obvious.
* "Really? The game with the slug guy and the weird turkey?"
-> children
= children
{advance_time(1)}
"Okay, first, how could you say that about my CHILDREN?" They look fake-appalled. "B, Gastropondi is a snail - it has a shell! And third, Astravis is an owl?"
You're realizing now that you DID, indeed, already know these things. You've osmosed more knowledge of this game than you thought.
* "Of course they are. No reasonable person would EVER make that mistake."
    "I'm glad you've seen the light. Now we can move forward, closer than before."
    ** "The fact that those two are your favorites is really telling."
    Genuine confusion is splayed all over their face. "What's wrong with my guys?"
        *** (gastropondi) "Like, of COURSE your favorite is the big dopey snail that trips and falls on the enemy as a special move.{constellation.randomtriangle: Your harshest insult is 'YOU'RE a random triangle!'}"
        *** (astravis) "Like, of COURSE your favorite is the astronomy-loving owl that has a specal move that gets stronger at night.{constellation.reallylikeit: You don't remember that spiel on astronomy earlier?"}
        - -> critterz
= critterz
{advance_time(1)}
They let out a laugh, sharp and loud. "DANG! Okay, sure! Which one are you, then? There are so many Critterz, they're gotta be one for you..."
* ["I'm obviously Jellywish."]"I'm ovbiously-"
* ["I'm obviously Amoebot."]"I'm obviously-"
* ["I'm obviously Stonesmasher."]"I'm obviously-"
- -> squibble

= squibble
{advance_time(1)}
They cut you off - you can practically see the lightbulb above their head. "NO. No, I know who you are. You're Squibble."
You vaguely remember Squibble - weird little octopus with three eyes and a permanent worried expression. Its special move is called Cry.
* "Wow, ok! Brutal!"
    "Nonono, you gotta let me explain! See, you wouldn't know this because you're not a Critterz Master like me," they say, having never seemed less cool in their life, "but Squibble is actually huge in the meta right now! See, it's got super high Guard and Magic Guard stats, and there's this item called the Squibble Stone-"
        ** "The Squibble Stone? Really sellin' Squibble to me here."
            "Okay, yeah, it sucks, but like, LISTEN. The Squibble stone doubles its already high stats so it can take a ton of hits while it cries its opponents to death! And that's why I chose Squibble. You complain and snark a little, but when push comes to shove, you could handle anything and come out the other side unscathed."
            *** "Wow, thank you. That means a lot, like, really!"
            Their speech was kinda beautiful, in a weird way? You felt yourself blushing a little as they said it.
            {change_mood(1)}
            "Hey, anytime! It's not like it's not true."
            ++++ [Look at the {final_option == 0:stars|sunrise}.]
            -> stars
            *** (dontcare)"...Cool, whatever. I really don't care."
            {change_mood(-2)}
            You were trying to be snarky and blasé, but one look at their face tells you that you went too far. You don't know what to say, so you just... don't say anything.
            ++++ [Look at the {final_option == 0:stars|sunrise}.]
            -> stars
-> END

== braceletfinished ==
{advance_time(1)}
~ have_bracelet = 1
"Yeah, I did! Now, c'mere, gimme your arm." You do as they say, and they tie it around your wrist. It's made really well - you don't know what an imperfection on something like this would look like, but it looks uniform, like something you'd buy in a store. 
{time >= 8:Now that it's a little lighter, you can see which colors you picked out! {bracelet_colors_nice == 0:And, ah. You picked lime green, bright neon magenta, and a weird maroon that look... well, like somebody picked them out in the dark.|And, oh! You picked out a red, orange, and yellow that look like fire, or maybe autumn leaves!}}
* {bracelet_colors_nice==0}"Wow, this turned out really nice despite the... gross colors."
* {bracelet_colors_nice==1}"Hey, this turned out really nice! And the colors are pretty, too!"
- -> compliment
= compliment
"Hey, you chose the colors, not me. But yes, it did turn out great. I dunno what else you expected!"
* "It's hard to do all that in the dark!"
    "And yet, I'm just that amazing. But, anyway, I'm glad you like it."
    You're going to keep this for a long time{bracelet_colors_nice==0:, weird as it is}.
    ++ [Look at the {final_option == 0:stars|sunrise}.]
-> stars

== apology ==
{advance_time(1)}
They're about to cut it with an, "It's okay," but you interrupt them.
* ["No. Like, for real, that was shitty of me."]"No. Like, for real, that was shitty of me. {apologytext()}"
    They look up at you, tentative but then relieved. "...Yeah, okay. Thank you, it really does mean a lot."
    ** "Are we still okay?"
    "Yeah, absolutely! God, it's weird being mad at you, I don't like it! Just don't do it again."
    *** "Okay."
    They smile at you, relieved, and turn their back to the sky again.
    ~ mood = 0
    ++++[Look at the {final_option == 0:stars|sunrise}.]
    -> stars

== function apologytext() ==

{forget.dodge:
~ return "I'm worried about you leaving and meeting so many people you forget about me. But I should've been honest with you about it, and I should've realized you'd never do that. It still lives in the back of my mind, but that's not anything I think either of us can help."
- else:
{family.squibble.dontcare:
~ return "I shouldn't have dismissed you like that. I know you care about this stuff, and it was really nice of you to think about me like that. I promise I'll listen more next time, okay?"
- else:
{first_thing.push.prytoofar:
~ return "I shouldn't have pushed the boundary. I'm kinda worried about you, y'know? This is BIG. But you shouldn't have to talk about anything you don't want to. I won't bug you about it again, okay?"
}
}
}

== goodbye ==
    An alarm on their phone goes off, {family.game:the Battle Critterz theme song, you think|a song from that game they love}, and they slap their hands on their knees. "Shit. Looks like it's time to go." They stand up, and you do, too. They look like they're about to say something, then falter before speaking again. 
    "I'm really glad we did this. I'm gonna miss you. Like, a lot. I think Number 101 was my favorite stargazing session, no contest.{bracelet_time != 999 and bracelet_time > 0: Oh! And, since I didn't have enough time to finish that bracelet, I'll mail it to you or something, okay?}"
    * {bracelet_time != 999 and bracelet_time > 0} "I'll be waiting for it."
    * "...Yeah. Yeah, that was my favorite session, too."
    - -> wait
= wait
They're packing up all their stuff, and you still haven't told them yet. They're about to leave, and you won't have told them. It terrifies you, and you almost don't, but that the last minute you shout,
* "Wait!"
"Yeah?"
** "I gotta tell you something before you go."
-> whatisit

= whatisit
{"What is it?"|}
{They start to look a little worried, and you wonder if they already know what you're about to say.|Shit. No way around it. You have to tell them.}
* ["I don't get how you could just... leave me here. Alone. And I know you can't do anything about it, but I can't stop myself from being mad at you. And I know it's not fair, it..."]{mood<0:"I don't get how you could just... leave me here. Alone. And-"|"I don't get how you could just... leave me here. Alone. And I know you can't do anything about it, but I can't stop myself from being mad at you. And I know it's not fair, it..."}
-> leaving
* "I have a crush on you. I have for... a while. And I know it's not gonna work out, but I can't NOT say anything anymore. I'm sorry."
-> crush
* "...Nothing, nevermind."
-> nevermind

= leaving
{mood<0:->sadleaving}
"...Oh."
* "Oh?"
    "Jeez, that's heavy. I'm sorry you've been holding that in for so long. And I'm sorry for leaving you behind, but... I have to. You know that, right?"
    ** "Yeah. Yeah, I do."
        "I'm pretty scared to move, too. This whole thing is just... so much. But I'm gonna make sure we stay in contact, okay?"
        *** "Okay."
        "It's gonna suck for a litte bit, maybe a while, but we're gonna figure it out. We'll stay friends. I promise. But I gotta go now. Text you when I'm on my way?"
        **** "...Yeah. Yeah, I'd like that. Thank you."
            "Anytime."
            You both pack up your things and you wish them one last goodbye before heading home. It hurts, it really hurts, but... you feel better. Maybe it'll be okay.
            -> END

-> END
= sadleaving
They cut you off again. They were frustrated at you before, but it's reached fever pitch now. "What? You're mad because I'm going off to college? How is that fair?"
* ["It's not, I know, I'm sorry."]"It's not, I know, I-"
    "Do you know how hard I've been working for this?"
    ** "Yeah."
        "You think I'm leaving YOU alone, do you know what it's gonna be like to move somewhere completely new, completely alone?"
        *** "Shit. I guess not."
            "Exactly! I'm terrified." You can hear their voice break a little. "So you have NO right to tell ME that I'm hurting YOU for this. {nevermind:Guess I get why you waited so long to say anything.|That's unfair.}"
                **** ["I'm sorry, I shouldn't have said anything."]"I'm sorry, I-"
                    "I'm not done! You could've come with me, too! Your grades are almost as good as mine, I would've helped you do everything you needed to. But you chose to stay here. And I didn't. And that's just how it has to be. Suck it up."
                    
                    You didn't even realize there were tears falling down your face, and neither did they - as soon as they finish their tirade, their face falls. "Shit. I'm sorry, I just-"
                    ***** "It's fine. Good luck at school, okay?"
                    You turn around and leave so you can't see their face. How did that go so wrong? Why did you say anything in the first place? Why couldn't you just keep your mouth shut? Your insides feel like they're tearing themselves apart. You need to sit down. This is not okay.
                    -> END
= crush
{mood>0: -> happycrush}
They breathe in, give a long sigh, and then look at you again. "...I probably should've figured that out by now, huh?"
* "Yeah. Probably."
    "...Look, I love you too, but only as a friend. I'm really sorry, I know that wasn't what you were looking for. I'm sorry."
    You knew it was coming, and you almost convince yourself it doesn't hurt.
    ** "It wasn't going to work out anyways. You're going off to school, it just..."
    "Yeah. I get what you mean. Shit. I'm really sorry."
        *** "But... do you still wanna be friends?"
        They look at you, a little confused? But then they nod their head. "If you're sure you're gonna be okay, then yeah. I do."
        **** "Good."
            "You seem... weirdly calm about this." You're not. But somehow, you're putting up a good enough front. "Are you sure you're okay? Do you need anything? Is... there anything I can do?"
            ***** "I think I need a little space. Is that okay?"
                "Yeah. Yeah, anything you need. I gotta leave, but... text me whenever you're okay to. I'm sorry, I'm really sorry."
                ****** "No, don't apologize. Have a safe drive."
                You two pack up the rest of your things in silence and then diverge. It hurts... less than you thought. Just saying it makes you feel better. You're dreading texting them back, but you think, with enough time, maybe you could. -> END
= happycrush
They look at you, stunned, almost as if they were doing some kind of mental math in their head. "I think... I like you, too."
* "You do?"
    THEY DO?
    "Yeah. Um. I've never thought about it before, but I'm willing to give it a try if you are?" God, you wanna say yes. So badly. But...
    ** "I wish we could, I really do. But you know this isn't gonna work out. I know it, too."
        "I mean, yeah, we'll be long-distance, but we've been friends long-distance before! Why can't we do it again?"
        *** "This is different. Very different."
            "You're right, I just... It just feels RIGHT, now that you said something, y'know?"
            **** "I know. Trust me, I've been thinking about it for... way too long."
            "Shit. I'm sorry. I really am. Maybe... maybe when I come back for breaks, maybe we can-"
            ***** "Stop. Let's just... take a minute. I think maybe we need some space."
            "...No. No, we can do this. We'll figure it out. I can-"
                ****** "I'm leaving. Let's talk in... a day." 
                "A day. Fine. I can do a day."
                God, this is going wrong in the worst way. Your heart is both soaring and shattering. You try and focus on just shattering, and then respons. "Maybe. If we can still be friends without... this hanging over our heads."
                ******* "Safe travels. Call me tomorrow, okay?"
                Without waiting for a response, you leave. It feels BAD, and it feels WEIRD, and it feels WRONG, but... it's the best decision for both of you. Now you just have to tell yourself that until you believe it. ->END
                
= nevermind
They sigh and put their hand on their hip. "No."
* "No?"
    "No. I can see it on your face, this is important. And you waited all night to tell me, so it must be pretty big. So, again, what is it?" -> whatisit
