import Ember from 'ember';

export default Ember.Route.extend({
  model() {
    return ['Marie Curie', 'Stephen Hawking', 'Albert Einstien'];
  }
});
