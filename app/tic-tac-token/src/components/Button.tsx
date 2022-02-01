interface Props {
  onClick: () => void;
  children: React.ReactNode;
}

const Button = ({ onClick, children }: Props) => {
  return (
    <button
      className="text-lg px-4 py-2 rounded-md shadow bg-blue-200 hover:bg-blue-300"
      onClick={onClick}
    >
      {children}
    </button>
  );
};

export default Button;
