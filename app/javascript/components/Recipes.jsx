import React from "react";
import { Link } from "react-router-dom";
import Select from "react-select";
import makeAnimated from 'react-select/animated';

const animatedComponents = makeAnimated();

class Recipes extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      recipes: [],
      options: [],
      selectedOptions: []
    };
  }

  componentDidMount() {
    const recipes_url = `/api/v1/recipes?query_params=${this.state.selectedOptions}`;
    fetch(recipes_url)
      .then(response => {
        if (response.ok) {
          return response.json();
        }
        throw new Error("Network response was not ok.");
      })
      .then(response => this.setState({ recipes: response }))
      .catch(() => this.props.history.push(recipes_url));

    const ingredients_url = "/api/v1/ingredients";
    fetch(ingredients_url)
      .then(response => {
        if (response.ok) {
          return response.json();
        }
        throw new Error("Network response was not ok.");
      })
      .then(response => {
        const options = response.map((ingredient) => (
          {value: ingredient.name, label: ingredient.name}
        ))
        this.setState({ options })
      })
      .catch(() => this.props.history.push(ingredients_url));
  }

  getRecipes(param) {
    let query_params = param.map((option) => (
      {name: option.value}
    ));

    const recipes_url = `/api/v1/recipes?query_params=${JSON.stringify(query_params)}`;
    fetch(recipes_url)
      .then(response => {
        if (response.ok) {
          return response.json();
        }
        throw new Error("Network response was not ok.");
      })
      .then(response => this.setState({ recipes: response }))
      .catch(() => this.props.history.push(recipes_url));
  }
  render() {
    const { recipes, options } = this.state;

    const allRecipes = recipes.map((recipe, index) => (
      <div key={index} className="col-md-6 col-lg-4">
        <div className="card mb-4">
          <div className="card-body">
            <h5 className="card-title">{recipe.name}</h5>
            <div>
              <h4>Ingredients</h4>
              <ul>
                {
                  recipe.ingredients.map((ingredient, index) => (
                    <li key={index}>{ingredient.name}</li>
                  ))
                }
              </ul>
            </div>
          </div>
        </div>
      </div>
    ));

    const noRecipe = (
      <div className="vw-100 vh-50 d-flex align-items-center justify-content-center">
        <h4>
          No recipes yet.
        </h4>
      </div>
    );

    return (
      <>
        <section className="jumbotron jumbotron-fluid text-center">
          <div className="container py-5">
            <h1 className="display-4">Recipes for every occasion</h1>
          </div>
        </section>
        <section className="jumbotron jumbotron-fluid text-center">
          <div className="container py-5">
            <Select
              closeMenuOnSelect={false}
              components={animatedComponents}
              isMulti
              options={options}
              onChange= {
                this.getRecipes.bind(this)
              }
            />
          </div>
        </section>
        <div className="py-5">
          <main className="container">
            <div className="row">
              {recipes.length > 0 ? allRecipes : noRecipe}
            </div>
            <Link to="/" className="btn btn-link">
              Home
            </Link>
          </main>
        </div>
      </>
    );
  }
}
export default Recipes;
