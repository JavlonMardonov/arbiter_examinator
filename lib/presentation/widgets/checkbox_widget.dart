import 'package:arbiter_examinator/data/models/quiz/option_data.dart';
import 'package:arbiter_examinator/data/models/quiz/quiz_data.dart';
import 'package:flutter/material.dart';

class CheckboxWidget extends StatefulWidget {
  final QuizData quiz;
  final String questionNumber;
  final bool isNextQuizAvailable;
  final Function(List<OptionData>) onPrimaryButtonTap;

  const CheckboxWidget({
    required this.quiz,
    required this.questionNumber,
    required this.isNextQuizAvailable,
    required this.onPrimaryButtonTap,
    super.key,
  });

  @override
  State<CheckboxWidget> createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {
  OptionData? _selectedOption;
  List<OptionData> _selectedOptions = [];

  @override
  void didUpdateWidget(covariant CheckboxWidget oldWidget) {
    if (oldWidget.quiz.id != widget.quiz.id) {
      setState(() {
        _selectedOption = null;
        _selectedOptions = [];
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${widget.questionNumber}-savol",
            style: TextStyle(
              color: Colors.grey[900],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.quiz.question.content,
            style: TextStyle(
              color: Colors.grey[900],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
              itemCount: widget.quiz.options.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final option = widget.quiz.options[index];

                return widget.quiz.quizType == QuizType.singleSelect
                    ? _SingleSelectOption(
                        selectedOption: _selectedOption,
                        currentOption: option,
                        onSelect: () {
                          setState(() {
                            _selectedOption = option;
                          });
                        },
                      )
                    : _OptionCheckboxItem(
                        option: option,
                        isSelcted: _selectedOptions.contains(option),
                        onToggle: (isSelected) {
                          setState(() {
                            isSelected
                                ? _selectedOptions.add(option)
                                : _selectedOptions.remove(option);
                          });
                        },
                      );
              },
            ),
          ),
          ElevatedButton(
              onPressed: (widget.quiz.quizType == QuizType.singleSelect &&
                          _selectedOption != null) ||
                      (widget.quiz.quizType == QuizType.multiSelect &&
                          _selectedOptions.isNotEmpty)
                  ? () {
                      widget.onPrimaryButtonTap(
                          widget.quiz.quizType == QuizType.singleSelect
                              ? [_selectedOption!]
                              : _selectedOptions);
                    }
                  : null,
              child: Container(
                child: Text(
                  widget.isNextQuizAvailable ? "Keyingi savol" : "Yakunlash",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )),
          const SizedBox(height: 50)
        ],
      ),
    );
  }
}

class _SingleSelectOption extends StatelessWidget {
  final OptionData currentOption;
  final OptionData? selectedOption;
  final VoidCallback onSelect;

  const _SingleSelectOption({
    required this.currentOption,
    required this.selectedOption,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Radio(
                activeColor: Colors.blue,
                fillColor: MaterialStatePropertyAll(
                  selectedOption == currentOption
                      ? Colors.blue
                      : Colors.grey[50],
                ),
                visualDensity: VisualDensity.compact,
                value: currentOption,
                groupValue: selectedOption,
                onChanged: (value) => onSelect(),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  currentOption.optionValue,
                  style: TextStyle(
                    color: Colors.grey[900],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _OptionCheckboxItem extends StatefulWidget {
  final bool isSelcted;
  final OptionData option;
  final Function(bool) onToggle;

  const _OptionCheckboxItem({
    required this.isSelcted,
    required this.option,
    required this.onToggle,
  });

  @override
  State<_OptionCheckboxItem> createState() => _OptionCheckboxItemState();
}

class _OptionCheckboxItemState extends State<_OptionCheckboxItem> {
  late bool _isSelected;

  @override
  Widget build(BuildContext context) {
    _isSelected = widget.isSelcted;

    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
        widget.onToggle(_isSelected);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              SizedBox(
                height: 20,
                width: 20,
                child: Checkbox(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  side: MaterialStateBorderSide.resolveWith(
                    (states) => BorderSide(
                      width: 1,
                      color: Colors.grey[50]!,
                    ),
                  ),
                  value: _isSelected,
                  onChanged: (_) {
                    setState(() {
                      _isSelected = !_isSelected;
                    });
                    widget.onToggle(_isSelected);
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  widget.option.optionValue,
                  style: TextStyle(
                    color: Colors.grey[900],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
