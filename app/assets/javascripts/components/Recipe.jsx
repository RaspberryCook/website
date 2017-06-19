class Recipe extends React.Component {

  constructor(props){
    super(props);
    this.state = {isHovered: false};
    // declare event here
    this.handleHover = this.handleHover.bind(this);
  }

  handleHover(){
    this.setState({
      isHovered: !this.state.isHovered
    });
  }

  render() {
    if(this.state.isHovered){
      return (
        <div
        className="col-md-3 col-sm-4 col-xs-6"
        onMouseEnter={this.handleHover}
        onMouseLeave={this.handleHover}
        >
          <figure className="recipe" >
            <ul>
              <li>{this.props.ingredients}</li>
            </ul>
            <figcaption>
              <a href={this.props.url}>{this.props.name}</a>
            </figcaption>
          </figure>
        </div>
      )

    }else{
      return (
        <div
        className="col-md-3 col-sm-4 col-xs-6"
        onMouseEnter={(this.handleHover)}
        >
          <figure className="recipe" >
            <a href={this.props.url}>
              <img src={this.props.imageUrl} className='img-responsive img-rounded' alt="Image for {this.props.name}" />
            </a>
            <figcaption>
              <a href={this.props.url}>{this.props.name}</a>
            </figcaption>
          </figure>
        </div>
      )
    }
  }
}
