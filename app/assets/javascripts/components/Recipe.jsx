class Recipe extends React.Component {

  constructor(props){
    super(props);
    this.state = {name: this.props.name};
    // declare event here
    this.handleHover = this.handleHover.bind(this);
  }

  handleHover(){
    this.setState({
      name: 'Hello'
    });
  }

  render() {
    return (
      <div
        className="col-md-3 col-sm-4 col-xs-6"
        onMouseEnter={this.handleHover}
      >
        <figure className="recipe" >
          <a href={this.props.url}>
            <img src={this.props.imageUrl} className='img-responsive img-rounded' alt="Image for {this.props.name}" />
          </a>
          <figcaption>
            <a href={this.props.url}>{this.state.name}</a>
          </figcaption>
    		</figure>
      </div>
    )
  }
}
