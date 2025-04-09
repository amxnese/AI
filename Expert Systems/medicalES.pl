% medical system expert

diagnose :-
    identify(Illness),
    write('The patient might be suffering from: '),
    write(Illness), nl,
    clear_answers.

% possible diagnoses
identify(diabetes) :- has_diabetes, !.
identify(flu)      :- has_flu, !.
identify(cold)     :- has_cold, !.
identify(unknown).

% identifying rules
has_diabetes :- diabetes_symptoms.
has_flu      :- flu_symptoms.
has_cold     :- cold_symptoms.

diabetes_symptoms :-
    confirm(weight_loss),
    confirm(frequent_urination),
    confirm(excessive_thirst),
    confirm(fatigue),
    confirm(skin_infections).

flu_symptoms :-
    confirm(fever),
    confirm(muscle_pain),
    confirm(headache),
    confirm(sore_throat),
    confirm(coughing).

cold_symptoms :-
    confirm(sneezing),
    confirm(runny_nose),
    confirm(mild_fever),
    confirm(sore_throat),
    confirm(congestion).

% questioning the patient
ask(Question) :-
    write('Does the patient have: '), write(Question), write('? (yes/no) '),
    read(Response), nl,
    ((Response == yes ; Response == y) ->
        assert(yes(Question)) ;
        assert(no(Question)), fail).

% handling answers
:- dynamic yes/1, no/1.

confirm(Symptom) :-
    (yes(Symptom) -> true ;
     no(Symptom)  -> fail ;
     ask(Symptom)).

% clearing stored answers
clear_answers :- retract(yes(_)), fail.
clear_answers :- retract(no(_)), fail.
clear_answers.
