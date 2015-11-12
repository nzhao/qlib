function mean_values=GetMeanValues(obj, dynamics, observables)
    dynamics.addObervable(observables);
    dynamics.calculate_mean_values();
    obj.render=dynamics.render;
    mean_values=obj.render.get_result();
end